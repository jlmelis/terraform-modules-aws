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
  description = "The name prefix for the database"
  default     = ""
}

variable "instance_class" {
  type        = string
  description = "Instance type to use at master instance. This will be the same instance class used on instances created by autoscaling"
  default     = "db.t3.medium"
}

variable "database_name" {
  type        = string
  description = "The name of the database to create when the DB instance is created"
  default     = ""
}

variable "db_subnet_group_name" {
  type        = string
  description = "The name of the DB subnet group to use for the DB instance"
  default     = ""
}

variable "engine" {
  type        = string
  description = "The database engine to use"
  default     = "aurora-postgresql"
}

variable "engine_version" {
  type        = string
  description = "The version of Aurora PostgreSQL. Updating this argument results in an outage"
  default     = "14.3"
}

variable "autoscaling_min_capacity" {
  type        = number
  description = "The minimum number of read replicas permitted when autoscaling is enabled"
  default     = 1
}

variable "autoscaling_max_capacity" {
  type        = number
  description = "The maximum number of read replicas permitted when autoscaling is enabled"
  default     = 2
}

variable "backup_retention_days" {
  type        = number
  description = "Number of days to retain backups"
  default     = 7
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block allowed to access the database"
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where to create database cluster and security groups"
  default     = ""
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs used by database"
  default     = []
}

variable "sns_alarm_topic_arn" {
  type        = string
  description = "The SNS Topic ARN to use for Cloudwatch Alarms"
  default     = ""
}

variable "alarm_cpu_threshold" {
  type        = number
  description = "CPU Percentage that should cause an alarm if the actual cpu average is greater than or equal for 300 seconds"
  default     = 90
}

variable "allowed_security_groups" {
  type        = list(string)
  description = "List of security group IDs to allow access to the database"
  default     = []
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks to allow access to the database"
  default     = []
}

variable "publicly_accessible" {
  type        = bool
  description = "If the DB instance should have a public access"
  default     = false
}