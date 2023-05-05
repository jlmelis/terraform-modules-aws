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
  description = "Assume role ARN"
  type        = string
  default     = ""
}

variable "name" {
  description = "VPC name"
  type        = string
}

variable "manage_default_security_group" {
  description = "Whether to manage the default security group"
  type        = bool
  default     = false
}

variable "default_security_group_ingress" {
  description = "A list of ingress rules to add to the default security group"
  type        = list(map(string))
  default     = []
}