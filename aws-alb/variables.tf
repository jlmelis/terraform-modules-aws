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

variable "certificate_arn" {
  description = "The certificate to use with the SSL listener"
  type        = string
  default     = ""
}

variable "http_port" {
  type        = number
  description = "Port on which the load balancer is listening"
  default     = 80
}

variable "https_port" {
  type        = number
  description = "SSL Port on which the load balancer is listening"
  default     = 443
}

variable "health_check_path" {
  type        = string
  description = "Destination for the health check request"
  default     = "/swagger/index.html"
}

variable "dns_zone_id" {
  description = "The ID of the Route53 hosted zone to create an alias record.  The Route53 hosted zone must be accessible via the dns_zone_role_arn"
  type        = string
  default     = ""
}

variable "dns_record_names" {
  type        = list(string)
  description = "he DNS name to use to create an alias record.  The Route53 hosted zone must be accessible via the dns_zone_role_arn"
  default     = []
}


variable "dns_zone_role_arn" {
  type        = string
  description = "The AWS assume role"
  default     = ""
}

variable "sns_alarm_topic_arn" {
  type        = string
  description = "The SNS Topic ARN to use for Cloudwatch Alarms"
  default     = ""
}

variable "alarm_unheathly_threshold" {
  type        = number
  description = "Number of unheathy hosts that should cause an alarm if the actual is greater than or equal for 60 seconds"
  default     = 1
}