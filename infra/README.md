# Terraform Infrastructure Documentation

This directory contains all Terraform code for provisioning the AWS serverless stack.

## Modules
- **sqs**: SQS queue for distributing scraping jobs
- **dynamodb**: DynamoDB table for deduplication and storage
- **cloudwatch**: Log group for Lambda logs
- **eventbridge**: Scheduler for periodic Lambda execution
- **lambda**: Lambda function deployment
- **iam**: IAM roles and policies

## Usage
- Edit variables in `main.tf` as needed
- Run `terraform init && terraform apply` to deploy

## Outputs
- SQS queue URL/ARN
- DynamoDB table name/ARN
- Lambda ARNs
- EventBridge rule ARN

For more details, see the main [README.md](../README.md).
