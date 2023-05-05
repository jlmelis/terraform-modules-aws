module "database" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 7.6.2"

  name                = var.name
  engine              = var.engine
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  autoscaling_enabled = false
  publicly_accessible = var.publicly_accessible
  #autoscaling_min_capacity = var.autoscaling_min_capacity
  #autoscaling_max_capacity = var.autoscaling_max_capacity
  instances = {
    one = {}
  }

  database_name          = var.database_name
  create_random_password = true

  create_db_subnet_group  = false
  vpc_id                  = var.vpc_id
  subnets                 = var.subnet_ids
  db_subnet_group_name    = var.db_subnet_group_name
  allowed_cidr_blocks     = var.allowed_cidr_blocks
  allowed_security_groups = var.allowed_security_groups
}

module "metric_alarm" {
  count   = var.sns_alarm_topic_arn != "" ? 1 : 0
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 4.2.0"

  alarm_name          = "RDS - CPU Usage High"
  alarm_description   = "CPU Usage Exceeds ${var.alarm_cpu_threshold}%"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = var.alarm_cpu_threshold
  period              = 300

  namespace   = "AWS/RDS"
  metric_name = "CPUUtilization"
  statistic   = "Average"

  dimensions = {
    DBClusterIdentifier = "${var.name}-postgresql"
  }

  alarm_actions = [var.sns_alarm_topic_arn]
}
