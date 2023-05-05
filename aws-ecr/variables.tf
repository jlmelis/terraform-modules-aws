variable "region" {
  type        = string
  description = "AWS Region to create resources in"
}

variable "tags" {
  description = "A set of key/value label pairs to assign to this to the resources"
  type        = map(string)
  default     = {}
}

variable "repositories" {
  type        = list(string)
  description = "The ECR repositories to create"
  default     = []
}

variable "image_retention_count" {
  type        = number
  description = "The number of tagged images to retain"
  default     = 60
}

variable "additional_aws_account_access" {
  type        = list(string)
  description = "Additional aws accounts with readonly access to the repositories"
  default     = []
}

variable "role_arn" {
  type        = string
  description = "The AWS assume role"
  default     = ""
}
