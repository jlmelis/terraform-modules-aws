variable "region" {
  type        = string
  description = "AWS Region"
}

variable "tags" {
  description = "A set of key/value label pairs to assign to this to resource"
  type        = map(string)
  default     = {}
}

variable "name" {
  type        = string
  description = "The name prefix to use for the load balancer, security groups, and target group"
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "The VPC to associate the load balancer security groups, and target group with."
  default     = ""
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to attach to the load balancer."
  default     = []
}

variable "security_group_id" {
  type        = string
  description = "The security group ID to assign to the load balancer."
  default     = ""
}