variable "name" {
  description = "Name of the IAM role"
  type        = string
}

variable "inline_policy" {
  description = "IAM policy JSON for the Lambda role"
  type        = string
}
