# 🧠 AI Interview Coach

An AI-powered interview preparation platform that generates personalised interview questions from a candidate’s CV and job description, simulates mock interviews, and evaluates responses using structured AI-driven rubrics.

---

## 🚀 Overview

This project simulates a real-world interview experience by:

- Parsing a user’s CV (PDF upload)
- Analysing a job description
- Generating tailored interview questions
- Running a chat-based mock interview
- Scoring and providing structured feedback on answers

The system is fully deployed on AWS with CI/CD automation.

---

## 🏗️ Architecture

#### Frontend 
- Next.js
  
#### Backend API 
- FastAPI (Dockerised)

#### AWS ECS 
- Fargate

#### AWS Services:
- S3 (CV storage)
- RDS (PostgreSQL)
- CloudWatch (logging)
  
#### OpenAI API 
- LLM layer

---

## 🧠 Core Features

### 📄 CV & JD Analysis
- Extracts structured data from CV
- Parses job descriptions into skill requirements
- Identifies skill gaps and alignment

### 🎯 Interview Generation
- Generates:
  - Technical questions
  - Behavioural questions
  - CV-specific probing questions

### 💬 Mock Interview Engine
- Chat-based interview flow
- Stateful session management
- Real-time question/answer loop

### 📊 AI Evaluation System
Each answer is scored using:
- Clarity
- Technical depth
- Relevance
- Structure (e.g. STAR method)

Outputs:
- Score (1–10)
- Strengths & weaknesses
- Ideal improved answer

---

## ☁️ Deployment

The system is deployed on AWS using containerised infrastructure.

### Infrastructure Components

- **ECS (Fargate):** Backend service runtime
- **S3:** CV file storage
- **RDS (PostgreSQL):** Persistent session storage
- **ALB:** API routing
- **CloudWatch:** Logging and monitoring

---

## 🔄 CI/CD Pipeline

Automated deployment via GitHub Actions:

1. Code pushed to `main`
2. Backend is linted and tested
3. Docker image is built
4. Image pushed to AWS ECR
5. ECS service updated automatically

---

## 🧪 Tech Stack

### Frontend
- Next.js `16.2.9`
- React `19.2.4`
- React DOM `19.2.4`
- TypeScript `5`
- Tailwind CSS `4`
- ESLint `9`

### Backend
- Python `3.14`
- FastAPI `0.138.2`
- Pydantic `2.13.4`
- Pydantic Settings `2.11.0`
- Uvicorn `0.32.1`
- python-multipart `0.0.30`
- pytest `9.1.1`
- pytest-asyncio `1.4.0`
- httpx2 `2.5.0`
- OpenAI API - client package not added yet

### Infrastructure
- AWS ECS (Fargate)
- AWS S3
- AWS RDS (Postgres)
- AWS ECR
- GitHub Actions

---

## ⚙️ Clone, Setup, And Run

If you are cloning this repo and want to run it locally, use the following runtime and commands.

### Required Runtime

- Node.js `24.18.0` via `nvm` for the frontend
- npm `11.16.0`
- Python `3.14`

The repository pins Python in `.python-version`, Node in `.nvmrc`, and backend dependencies in `backend/requirements.txt` and `backend/requirements-dev.txt`.

### Create The Local Environment

#### Frontend

```bash
nvm install
nvm use
cd frontend
npm install
```

#### Backend

```bash
cd backend
python3.14 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements-dev.txt
```

### Environment Files

- Backend settings are loaded from `backend/.env`
- A starter template is available at `backend/.env.example`

### Start The Frontend

```bash
cd frontend
npm run dev
```

The frontend will be available at `http://localhost:3000`.

### Start The API

```bash
cd backend
source .venv/bin/activate
uvicorn app.main:app --reload
```

The API will be available at `http://127.0.0.1:8000`.

The currently implemented endpoint is:

- `GET /api/v1/health`

### Run Tests

```bash
cd backend
source .venv/bin/activate
python -m pytest ../tests/test_config.py ../tests/test_health.py
```

### Validate The Frontend

```bash
cd frontend
npm run lint
npm run build
```

### Current Repo State

- The backend should be run from the `backend` directory when using the local `.venv`
- The frontend lives in `frontend` as a Next.js App Router app
- The frontend currently validates cleanly with `npm run lint` and `npm run build` on Node `24.18.0`
- The only implemented backend endpoint today is the health check

---

## 📁 Project Structure

```

/frontend   → Next.js UI
/backend    → FastAPI server
/infra      → Docker + CI/CD configs
/prompts    → LLM prompt templates
/tests      → Unit + integration tests
/docs       → Architecture decisions
```

### 🧠 Key Engineering Highlights

--- 

- End-to-end AI pipeline (CV → JD → interview → scoring)
- LLM-based structured evaluation system
- Production-style cloud deployment on AWS
- Fully automated CI/CD pipeline
- Stateful conversational interview system

--- 

### 📈 Future Improvements
- Voice-based interview mode
- Adaptive difficulty questioning
- Multi-interviewer simulation
- Personal performance tracking over time


