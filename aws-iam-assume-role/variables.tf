variable "name" {
  type        = string
  description = "The name of the role to allow for a trust relationship"
  default     = "developertown-admins"
}

variable "account" {
  type        = string
  description = "The account number to allow for a trust relationship"
  default     = "216430079837"
}

variable "principal_tag_key" {
  type        = string
  description = "The key of the tag to use to check for access permissions"
  default     = ""
}

variable "principal_tag_value" {
  type        = string
  description = "The value of the tag to use to check for access permissions"
  default     = ""
}

variable "policy_arn" {
  type        = string
  description = "The ARN of the AWS managed policy to attach to the created role"
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "role_arn" {
  type        = string
  description = "The AWS assume role"
  default     = ""
}

variable "region" {
  type        = string
  description = "AWS Region"
}