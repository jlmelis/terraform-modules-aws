variable "region" {
  type        = string
  description = "AWS Region to create resources"
}

variable "tags" {
  description = "A set of key/value label pairs to assign to this to the resources"
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
  description = "The name prefix to use for the ecs cluster, security group, IAM roles, and IAM policies"
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "The VPC to associate the ecs cluster security groups with"
  default     = ""
}
