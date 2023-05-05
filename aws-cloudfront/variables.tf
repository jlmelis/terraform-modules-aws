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

variable "logs_bucket_domain_name" {
  description = "Name to be used for the web resources bucket"
  type        = string
  default     = ""
}

variable "web_resources_bucket_id" {
  description = "The web resources bucket id"
  type        = string
  default     = ""
}

variable "web_resources_bucket_regional_domain_name" {
  description = "Domain name to associate with the cloudfront origin"
  type        = string
  default     = ""
}

variable "web_resources_bucket_arn" {
  description = "The web resources ARN to grant s3:GetObject permission to"
  type        = string
  default     = ""
}

variable "route53_domain_names" {
  description = "The route 53 domain names"
  type        = list(string)
  default     = []
}

variable "route53_zone_id" {
  description = "The route 53 zone id to associate a route 53 A record with"
  type        = string
  default     = ""
}

variable "apex_dns_zone_id" {
  description = "The route 53 zone id to associate a route 53 A record with"
  type        = string
}

variable "apex_alias" {
  description = "The DNS zone to use for SSL certificates, and Route 53 records"
  type        = bool
  default     = false
}

variable "acm_certificate_arn" {
  description = "The acm viewer certificate arn to use in the cloudfront distribution"
  type        = string
  default     = ""
}
