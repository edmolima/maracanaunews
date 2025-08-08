# Security Policy

## Reporting a Vulnerability
If you discover a security vulnerability, please report it by emailing edmolima@gmail.com. Do not open public issues for security problems.

## Open Source Security Best Practices
- **No secrets or credentials are versioned.** Only placeholders in `.env.example`.
- **OIDC role for CI/CD** uses least privilege and is restricted to ARNs dos recursos do projeto.
- **S3 state bucket is private** and only accessible by the OIDC role.
- **No public endpoints** are exposed by default.
- **IAM policies** are scoped to only the resources needed (Lambda, SQS, DynamoDB, CloudWatch, S3).
- **Contributors must never commit real secrets.**
- **All PRs and issues are reviewed for security impact.**

## How to Contribute Securely
- Never commit real AWS credentials, tokens, or secrets.
- Use only `.env.example` for variable templates.
- If you see a potential security issue, report it privately.
- Follow the principle of least privilege in all code and infra changes.

## Monitoring
- AWS CloudTrail and GuardDuty are recommended for monitoring and alerting on suspicious activity.
- All roles and policies are reviewed regularly.
