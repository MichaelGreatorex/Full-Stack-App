# Full-Stack Application Template

A containerized full-stack application repository with a Next.js frontend, FastAPI backend, PostgreSQL data layer, and AWS-oriented deployment architecture.

---

[![Backend CI](https://github.com/${USERNAME}/${PROJECT_NAME}/actions/workflows/backend-ci.yml/badge.svg)](https://github.com/${USERNAME}/${PROJECT_NAME}/actions/workflows/backend-ci.yml)

[![Backend CI](https://github.com/MichaelGreatorex/Full-Stack-App/actions/workflows/backend-ci.yml/badge.svg)](https://github.com/MichaelGreatorex/Full-Stack-App/actions/workflows/backend-ci.yml)

---

## Overview

This repository provides a production-style foundation for building modern web applications with:

- A typed frontend client
- A versioned backend API
- A relational persistence layer
- Container-first local development
- CI/CD automation for validation and deployment

The system is fully deployed on AWS with CI/CD automation.

---

## Architecture

### Frontend Architecture

- Next.js

### Backend API Architecture

- FastAPI (Dockerized)

### Compute Architecture

- AWS ECS (Fargate)

### AWS Service Architecture

- S3 (object storage)
- RDS (PostgreSQL)
- CloudWatch (logging)

### AI Layer

- OpenAI API

---

## Core Features

### API-First Service Design

- Versioned REST API routes under `/api/v1`
- Built-in health endpoint for runtime checks
- Request/response modeling with Pydantic

### Frontend + Backend Separation

- Next.js frontend application
- FastAPI backend service
- Service-to-service communication through HTTP APIs

### Local Developer Workflow

- Docker Compose orchestration for local parity
- Startup-time backend test gate before app launch
- Scripted helpers for stack lifecycle management

### Operational Readiness

- Container health checks for service monitoring
- Cloud-oriented deployment targets on AWS ECS (Fargate)
- Logging and observability via CloudWatch


---

## Deployment

The system is deployed on AWS using containerized infrastructure.

### Deployment Components

- ECS (Fargate): backend service runtime
- S3: object/file storage
- RDS (PostgreSQL): persistent session storage
- ALB: API routing
- CloudWatch: logging and monitoring

---

## CI/CD Pipeline

Automated deployment via GitHub Actions:

1. Code pushed to `main`
2. Backend is linted and tested
3. Docker image is built
4. Image pushed to AWS ECR
5. ECS service updated automatically

---

## Tech Stack

### Frontend Stack

- Next.js `16.2.9`
- React `19.2.4`
- React DOM `19.2.4`
- TypeScript `5`
- Tailwind CSS `4`
- ESLint `9`

### Backend Stack

- Python `3.14`
- FastAPI `0.138.2`
- Pydantic `2.13.4`
- Pydantic Settings `2.11.0`
- Uvicorn `0.32.1`
- python-multipart `0.0.30`
- pytest `9.1.1`
- pytest-asyncio `1.4.0`
- httpx2 `2.5.0`

### Infrastructure Stack

- AWS ECS (Fargate)
- AWS S3
- AWS RDS (PostgreSQL)
- AWS ECR
- GitHub Actions

---

## Clone, Setup, And Run

If you are cloning this repository and want to run it locally, use the following runtime and commands.

### Required Runtime

- Docker Desktop (with Docker Compose)

Optional (only for host-based testing workflows):

- Node.js `24.18.0` via `nvm` for the frontend
- npm `11.16.0`
- Python `3.14`

The repository pins Python in `.python-version`, Node in `.nvmrc`, and backend dependencies in `backend/requirements.txt` and `backend/requirements-dev.txt`.

### Environment Files

- Backend settings are loaded from `backend/.env`
- A starter template is available at `backend/.env.example`

### Full Container Stack (Frontend + Backend + Postgres)

Docker Compose is the canonical local startup path. From repository root, start all three services:

```bash
docker compose up --build
```

Optional: override the local Postgres password for containers:

```bash
export POSTGRES_PASSWORD="your-local-password"
docker compose up --build
```

This starts:

- Postgres on `127.0.0.1:5432`
- Backend pytests (run once at startup) and then FastAPI on `http://127.0.0.1:8000`
- Next.js frontend on `http://127.0.0.1:3000`

If tests fail, the backend container exits and `docker compose up` reports the failure in backend logs.

Default local connection string (also in `backend/.env.example`):

```text
postgresql://app_user:app_password@127.0.0.1:5432/app_db
```

Stop the stack:

```bash
docker compose down
```

Reset Postgres data volume:

```bash
docker compose down -v
```

### Optional Wrapper Scripts

The scripts below now proxy to Docker Compose for convenience.

All services:

```bash
./scripts/dev-stack.sh up
./scripts/dev-stack.sh status
./scripts/dev-stack.sh down
```

Postgres only:

```bash
./scripts/postgres.sh up
./scripts/postgres.sh status
./scripts/postgres.sh down
```

### Run Tests Manually

```bash
cd backend
source .venv/bin/activate
python -m pytest -vv ../tests
```

### Test Suite Coverage

The backend test suite currently validates configuration behavior, API health behavior, and API route wiring.

#### `tests/test_config.py`

- `test_settings_parse_comma_separated_allowed_origins`
  - Verifies comma-separated `allowed_origins` input is parsed into a clean list.
- `test_settings_convert_empty_strings_to_none`
  - Verifies empty and whitespace values for optional settings become `None`.

#### `tests/test_health.py`

- `test_health_check`
  - Verifies `GET /api/v1/health` returns HTTP 200 and `{"status": "ok"}`.

#### `tests/test_routes.py`

- `test_openapi_includes_expected_v1_routes`
  - Parameterized test that verifies each expected v1 route is present in `GET /openapi.json`.
  - Covered routes:
    - `/api/v1/health`
    - Additional placeholder v1 routes for upload, workflow, and session retrieval

#### `tests/conftest.py`

- Provides the shared FastAPI `TestClient` fixture used by API tests.

#### Current Coverage Boundaries

- The suite currently checks route registration and API shape, not full business logic.
- Placeholder route handlers are intentionally not exercised yet.
- As route implementations are added, add behavior tests alongside each endpoint.

### Validate Frontend

```bash
cd frontend
npm run lint
npm run build
```

### Current Repository State

- The frontend lives in `frontend` as a Next.js App Router app
- The backend lives in `backend` as a FastAPI app
- Local runtime is intended to be container-first via Docker Compose
- The frontend validates with `npm run lint` and `npm run build` on Node `24.18.0`
- The only fully implemented backend endpoint today is the health check

---

## Project Structure

```text
/frontend   -> Next.js UI
/backend    -> FastAPI server
/infra      -> Docker + CI/CD configs
/prompts    -> LLM prompt templates
/tests      -> Unit + integration tests
/docs       -> Architecture decisions
```

---

## Key Engineering Highlights

- Modular full-stack architecture (Next.js + FastAPI + PostgreSQL)
- Versioned API design with centralized route wiring
- Production-style cloud deployment on AWS
- Automated CI/CD pipeline
- Container-first local development workflow

---

## Future Improvements

- Expand backend route implementations beyond placeholders
- Add endpoint-level behavior and integration tests
- Add database migrations and seed data workflow
- Extend observability with metrics and tracing
