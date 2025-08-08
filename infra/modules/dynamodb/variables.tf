variable "name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "Billing mode for DynamoDB table"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "Hash key attribute name"
  type        = string
  default     = "id"
}

variable "hash_key_type" {
  description = "Hash key attribute type (S, N, B)"
  type        = string
  default     = "S"
}
