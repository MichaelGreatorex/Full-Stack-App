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
- Next.js
- React

### Backend
- FastAPI
- Python
- OpenAI API

### Infrastructure
- AWS ECS (Fargate)
- AWS S3
- AWS RDS (Postgres)
- AWS ECR
- GitHub Actions

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


