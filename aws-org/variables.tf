variable "region" {
  type        = string
  description = "AWS Region to create resources in"
}

variable "tags" {
  description = "A set of key/value label pairs to assign to this to the resources"
  type        = map(string)
  default     = {}
}

variable "member_accounts" {
  type = map(object({ name = string, email = string, role = string }))

  default = {
    dev = {
      name  = "testOrg",
      email = "test@email.com",
      role  = "test-role"
    }
  }
}

variable "org" {
  type        = string
  description = "The organization for which resources are being created"
  default     = "testOrg"
}

variable "parent_id" {
  type        = string
  description = "The parent id for the organization"
  default     = "r-0w0m000000"
}