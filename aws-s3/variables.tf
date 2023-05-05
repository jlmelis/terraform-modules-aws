variable "region" {
  type        = string
  description = "AWS Region"
}

variable "role_arn" {
  type        = string
  description = "The role arn to assume"
}

variable "environment" {
  description = "The environment which is being created"
  type        = string
}

variable "bucket_name" {
  description = "The name of the project"
  type        = string
}

variable "tags" {
  description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
  type        = map(string)
  default     = {}
}

variable "logs_bucket_id" {
  description = "The log bucket id"
  type        = string
  default     = ""
}
