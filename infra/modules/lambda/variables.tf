variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "Lambda handler (e.g. index.handler)"
  type        = string
}

variable "runtime" {
  description = "Lambda runtime (e.g. nodejs18.x)"
  type        = string
}

variable "role_arn" {
  description = "IAM role ARN for Lambda"
  type        = string
}

variable "filename" {
  description = "Path to deployment package zip"
  type        = string
}

variable "timeout" {
  description = "Lambda timeout in seconds"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Lambda memory size in MB"
  type        = number
  default     = 128
}

variable "environment_variables" {
  description = "Environment variables for Lambda"
  type        = map(string)
  default     = {}
}

variable "log_retention" {
  description = "Log retention in days"
  type        = number
  default     = 14
}
