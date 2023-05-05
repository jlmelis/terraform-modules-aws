variable "region" {
  type        = string
  description = "AWS Region"
}

variable "tags" {
  description = "A set of key/value label pairs to assign to this to resource"
  type        = map(string)
  default     = {}
}

variable "role_arn" {
  type        = string
  description = "The AWS assume role"
  default     = ""
}

variable "name" {
  type        = string
  description = "The name prefix of the new secret"
  default     = ""
}

variable "secrets" {
  description = "A set of key/value secret pairs to store in secrets manager"
  type        = map(string)
  default     = {}
}
