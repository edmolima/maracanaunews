# Lambda API Reference

This document describes the main interfaces and environment variables for all Lambda packages.

## Environment Variables
- `AWS_REGION`: AWS region
- `DYNAMODB_TABLE`: DynamoDB table name
- `SQS_QUEUE_URL`: SQS queue URL
- `SOURCE`: Source identifier (e.g., `maracanet`)
- `MY_API_KEY`: (if needed)

## Scheduler Lambda
- Fetches URLs from maracanet.com
- Sends messages to SQS

## Worker Lambda
- Consumes SQS messages
- Scrapes news, deduplicates, and stores in DynamoDB

## Shared Utilities
- All shared code should be in a shared package in `packages/`

## Adding a New Source
- Create a new package in `packages/`
- Implement the handler with the same interface
- Add to build/zip logic if needed

---

*Generate TypeDoc or similar for full API docs if needed.*
