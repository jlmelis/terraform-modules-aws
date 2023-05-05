variable "region" {
  type        = string
  description = "AWS Region"
}

variable "tags" {
  description = "A set of key/value label pairs to assign to this to resource"
  type        = map(string)
  default     = {}
}

variable "dns_name" {
  description = "The DNS zone to create"
  type        = string
}

variable "dns_ttl" {
  type        = number
  description = "The TTL for Route53 NS Records"
  default     = 60
}

variable "role_arn" {
  type        = string
  description = "The AWS assume role"
  default     = ""
}

variable "parent_dns_zone_id" {
  description = "The Route53 Zone to create an NS Record"
  type        = string
  default     = ""
}

variable "parent_role_arn" {
  type        = string
  description = "The AWS assume role"
  default     = ""
}


