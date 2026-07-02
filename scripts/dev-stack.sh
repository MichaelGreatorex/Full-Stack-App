#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RUN_DIR="$ROOT_DIR/.run"
PID_FILE="$RUN_DIR/dev-stack.pid"
FRONTEND_LOG="$RUN_DIR/frontend.log"
BACKEND_LOG="$RUN_DIR/backend.log"

require_file() {
  local file_path="$1"
  local message="$2"
  if [[ ! -f "$file_path" ]]; then
    echo "$message"
    exit 1
  fi
}

is_running() {
  local pid="$1"
  kill -0 "$pid" >/dev/null 2>&1
}

wait_for_process() {
  local pid="$1"
  local name="$2"

  for _ in {1..40}; do
    if is_running "$pid"; then
      return 0
    fi
    sleep 0.1
  done

  echo "$name failed to start (PID $pid is not running)."
  return 1
}

wait_for_http() {
  local url="$1"
  local name="$2"

  if ! command -v curl >/dev/null 2>&1; then
    echo "curl not available; skipping HTTP readiness check for $name."
    return 0
  fi

  for _ in {1..60}; do
    if curl -fsS --max-time 2 "$url" >/dev/null 2>&1; then
      return 0
    fi
    sleep 0.25
  done

  echo "$name did not become healthy at $url in time."
  return 1
}

stop_pid_tree() {
  local pid="$1"
  local name="$2"

  if [[ -z "$pid" ]] || ! is_running "$pid"; then
    echo "$name PID $pid is not running."
    return 0
  fi

  pkill -TERM -P "$pid" >/dev/null 2>&1 || true

  kill "$pid" >/dev/null 2>&1 || true
  for _ in {1..20}; do
    if ! is_running "$pid"; then
      echo "Stopped $name ($pid)."
      return 0
    fi
    sleep 0.1
  done

  pkill -KILL -P "$pid" >/dev/null 2>&1 || true
  kill -9 "$pid" >/dev/null 2>&1 || true
  if ! is_running "$pid"; then
    echo "Force stopped $name ($pid)."
    return 0
  fi

  echo "Warning: could not fully stop $name ($pid)."
  return 0
}

load_nvm() {
  export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
  require_file "$NVM_DIR/nvm.sh" "nvm not found at $NVM_DIR/nvm.sh"
  # shellcheck disable=SC1090
  . "$NVM_DIR/nvm.sh"
  if [[ -f "$ROOT_DIR/.nvmrc" ]]; then
    nvm use >/dev/null
  fi
}

run_pytests() {
  echo "Running backend tests..."
  require_file "$ROOT_DIR/backend/.venv/bin/activate" "Backend venv is missing. Create it in backend/.venv first."

  # shellcheck disable=SC1091
  source "$ROOT_DIR/backend/.venv/bin/activate"
  (
    cd "$ROOT_DIR/backend"
    python -m pytest -vv ../tests
  )
}

start_backend() {
  echo "Starting backend..."
  # shellcheck disable=SC1091
  source "$ROOT_DIR/backend/.venv/bin/activate"
  (
    cd "$ROOT_DIR/backend"
    nohup uvicorn app.main:app --reload >"$BACKEND_LOG" 2>&1 &
    echo $! >"$RUN_DIR/backend.pid"
  )
}

start_frontend() {
  echo "Starting frontend..."
  load_nvm
  (
    cd "$ROOT_DIR/frontend"
    nohup npm run dev >"$FRONTEND_LOG" 2>&1 &
    echo $! >"$RUN_DIR/frontend.pid"
  )
}

write_pid_file() {
  local backend_pid
  local frontend_pid
  backend_pid="$(cat "$RUN_DIR/backend.pid")"
  frontend_pid="$(cat "$RUN_DIR/frontend.pid")"

  cat >"$PID_FILE" <<EOF
BACKEND_PID=$backend_pid
FRONTEND_PID=$frontend_pid
EOF

  rm -f "$RUN_DIR/backend.pid" "$RUN_DIR/frontend.pid"
}

up() {
  mkdir -p "$RUN_DIR"

  if [[ -f "$PID_FILE" ]]; then
    # shellcheck disable=SC1090
    source "$PID_FILE"
    if is_running "$BACKEND_PID" || is_running "$FRONTEND_PID"; then
      echo "Dev stack already running. Use './scripts/dev-stack.sh down' first."
      exit 1
    fi
    rm -f "$PID_FILE"
  fi

  run_pytests
  start_backend
  start_frontend
  write_pid_file

  # shellcheck disable=SC1090
  source "$PID_FILE"

  wait_for_process "$BACKEND_PID" "Backend" || {
    down
    exit 1
  }
  wait_for_process "$FRONTEND_PID" "Frontend" || {
    down
    exit 1
  }
  wait_for_http "http://127.0.0.1:8000/api/v1/health" "Backend" || {
    down
    exit 1
  }
  wait_for_http "http://localhost:3000" "Frontend" || {
    down
    exit 1
  }

  echo ""
  echo "Dev stack is running:"
  echo "- Backend PID:  $BACKEND_PID (http://127.0.0.1:8000)"
  echo "- Frontend PID: $FRONTEND_PID (http://localhost:3000)"
  echo "- Backend log:  $BACKEND_LOG"
  echo "- Frontend log: $FRONTEND_LOG"
}

down() {
  if [[ ! -f "$PID_FILE" ]]; then
    echo "No running dev stack found."
    exit 0
  fi

  # shellcheck disable=SC1090
  source "$PID_FILE"

  stop_pid_tree "$FRONTEND_PID" "frontend"
  stop_pid_tree "$BACKEND_PID" "backend"

  rm -f "$PID_FILE"
}

status() {
  if [[ ! -f "$PID_FILE" ]]; then
    echo "Dev stack is not running."
    exit 0
  fi

  # shellcheck disable=SC1090
  source "$PID_FILE"

  if is_running "$BACKEND_PID"; then
    echo "Backend running ($BACKEND_PID)."
  else
    echo "Backend not running (stale PID: $BACKEND_PID)."
  fi

  if is_running "$FRONTEND_PID"; then
    echo "Frontend running ($FRONTEND_PID)."
  else
    echo "Frontend not running (stale PID: $FRONTEND_PID)."
  fi
}

case "${1:-}" in
  up)
    up
    ;;
  down)
    down
    ;;
  status)
    status
    ;;
  *)
    echo "Usage: ./scripts/dev-stack.sh {up|down|status}"
    exit 1
    ;;
esac
