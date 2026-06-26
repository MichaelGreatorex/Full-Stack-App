# Infrastructure

This directory contains infrastructure configuration for the AI Interview Coach platform.

## Contents

```
infra/
├── docker/       → Dockerfile and docker-compose configurations
└── aws/          → AWS infrastructure definitions (ECS, RDS, S3, etc.)
```

## Services

- **ECS (Fargate):** Backend service container runtime
- **S3:** CV file storage
- **RDS (PostgreSQL):** Persistent session storage
- **ALB:** API routing and load balancing
- **ECR:** Container image registry
- **CloudWatch:** Logging and monitoring

## Docker

The backend is containerised with Docker. See `docker/` for Dockerfile and compose configurations.

## CI/CD

GitHub Actions workflows are defined in `.github/workflows/`. They handle:

1. Linting and testing on pull requests
2. Building and pushing Docker images to ECR on merge to `main`
3. Updating the ECS service to deploy the new image

> **Note:** This directory is a placeholder. Infrastructure definitions will be added in a subsequent PR.
