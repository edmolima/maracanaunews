variable "name" {
  description = "Name of the CloudWatch Log Group"
  type        = string
}

variable "retention_in_days" {
  description = "Retention period in days"
  type        = number
  default     = 14
}
