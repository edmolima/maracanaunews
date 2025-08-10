# ADR 0002: Serverless AWS Architecture

## Status
Accepted

## Context
We need a scalable, cost-effective, and maintainable way to scrape and process news data. AWS serverless services provide managed, event-driven compute and storage with minimal operational overhead.


## Decision
- Use AWS Lambda for all compute (scheduler, worker, etc). Source in `packages/`, zipped in `lambdas/`.
- Use SQS for decoupling and distributing scraping jobs.
- Use DynamoDB for storing news data and deduplication.
- Use EventBridge for scheduling and orchestration.
- Use CloudWatch for logging and monitoring.
- All resources are provisioned via Terraform.
- CI/CD and automation are managed in `.github/workflows/` and `.github/actions/`.

## Consequences
- Minimal AWS cost and operational burden.
- High scalability and reliability.
- Infrastructure is reproducible and versioned.
