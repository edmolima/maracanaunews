# ADR 0003: CI/CD and Security

## Status
Accepted

## Context
To ensure safe, automated, and open source-friendly deployments, we need a secure CI/CD pipeline and strict security practices.

## Decision
- Use GitHub Actions for all CI/CD workflows.
- Use OIDC for secure, secretless AWS authentication.
- Each Lambda and infra has its own modular workflow.
- All IAM roles use least privilege and are scoped to project resources only.
- No secrets or credentials are versioned; only placeholders are used.
- All contributors must follow security best practices (see SECURITY.md).

## Consequences
- No AWS credentials are exposed in CI/CD.
- Open source ready and safe for external contributors.
- Security posture is clear and enforceable.
