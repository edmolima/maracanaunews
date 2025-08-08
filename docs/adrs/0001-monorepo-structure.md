# ADR 0001: Monorepo Structure

## Status
Accepted

## Context
To support a scalable, maintainable, and modular serverless architecture, we decided to use a monorepo structure. This enables code sharing, unified tooling, and independent deployment for each Lambda and infrastructure module.

## Decision
- All code is organized in a single repository.
- Each Lambda function is in its own package under `packages/` (e.g., `lambda`, `worker`, `scheduler`).
- Shared configuration (ESLint, Prettier, TSConfig, Vitest) is centralized in `packages/config/`.
- Infrastructure as code (Terraform) is in the `infra/` directory.
- CI/CD is modular, with workflows for infra and for each Lambda, using GitHub Actions and OIDC.

## Consequences
- Enables fast, isolated builds and deployments.
- Shared code and config are DRY and versioned.
- CI/CD is scalable and secure.
