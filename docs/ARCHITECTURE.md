# Architecture Overview

![Architecture Diagram](https://raw.githubusercontent.com/edmolima/maracanaunews/main/docs/architecture-diagram.png)

## Flow
- EventBridge triggers the Scheduler Lambda every hour
- Scheduler Lambda fetches URLs and sends to SQS
- SQS triggers Worker Lambdas
- Worker Lambdas scrape, deduplicate, and store in DynamoDB
- All logs go to CloudWatch

## Source Structure
- Lambda source: `packages/`
- Zipped artifacts: `lambdas/`
- Infra: `infra/`
- Workflows: `.github/workflows/`
- Custom actions: `.github/actions/`

## Extending
- Add new sources as new packages in `packages/`
- Add new workflows or actions as needed

---

*Add a PNG diagram at docs/architecture-diagram.png for visual reference.*
