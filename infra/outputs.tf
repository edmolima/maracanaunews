output "sqs_queue_url" {
  description = "URL of the SQS queue"
  value       = module.sqs.this_url
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = module.dynamodb.name
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch Log Group"
  value       = module.cloudwatch.name
}
