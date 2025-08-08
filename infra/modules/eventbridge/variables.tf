variable "name" {
  description = "Name of the EventBridge rule"
  type        = string
}

variable "description" {
  description = "Description of the rule"
  type        = string
  default     = ""
}

variable "schedule_expression" {
  description = "Schedule expression (e.g. cron or rate)"
  type        = string
}

variable "target_arn" {
  description = "ARN of the Lambda function to trigger"
  type        = string
}
