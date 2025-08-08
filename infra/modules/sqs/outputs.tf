output "this_url" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.this.url
}

output "this_arn" {
  description = "ARN of the SQS queue"
  value       = aws_sqs_queue.this.arn
}
