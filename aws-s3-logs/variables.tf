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

variable "log_retention_days" {
  type        = number
  description = "Number of days to retain logs"
  default     = 7
}
