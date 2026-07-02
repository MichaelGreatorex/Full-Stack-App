# Infrastructure

This directory contains infrastructure notes and placeholders for the AI Interview Coach platform.

## Contents

```text
infra/
└── README.md
```

## Local Container Runtime

Local containers are defined at repository root in [docker-compose.yml](../docker-compose.yml).

- Start local stack: `docker compose up --build`
- Stop local stack: `docker compose down`
- Reset local volumes: `docker compose down -v`

Backend and frontend container images are defined in:

- [backend/Dockerfile](../backend/Dockerfile)
- [frontend/Dockerfile](../frontend/Dockerfile)

## Services

- **ECS (Fargate):** Backend service container runtime
- **S3:** CV file storage
- **RDS (PostgreSQL):** Persistent session storage
- **ALB:** API routing and load balancing
- **ECR:** Container image registry
- **CloudWatch:** Logging and monitoring

## CI/CD

GitHub Actions workflows are defined in `.github/workflows/`. They handle:

1. Linting and testing on pull requests
2. Building and pushing Docker images to ECR on merge to `main`
3. Updating the ECS service to deploy the new image

> **Note:** This directory is a placeholder. Infrastructure definitions will be added in a subsequent PR.
