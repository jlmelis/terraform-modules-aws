variable "region" {
  type        = string
  description = "AWS Region"
}

variable "environment" {
  description = "The environment which is being created"
  type        = string
}

variable "project" {
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
