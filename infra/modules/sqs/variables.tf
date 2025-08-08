variable "name" {
  description = "Name of the SQS queue"
  type        = string
}

variable "policy" {
  description = "JSON policy for the SQS queue (optional)"
  type        = string
  default     = null
}
