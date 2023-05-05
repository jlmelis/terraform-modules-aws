locals {
  log_group_name = "${var.name}-ecs-logs"
  secrets        = [for k, v in var.secrets : { name = k, valueFrom = v }]

  env_vars_keys        = var.map_environment != null ? keys(var.map_environment) : var.environment != null ? [for m in var.environment : lookup(m, "name")] : []
  env_vars_values      = var.map_environment != null ? values(var.map_environment) : var.environment != null ? [for m in var.environment : lookup(m, "value")] : []
  sorted_env_vars_keys = sort(local.env_vars_keys)
  env_vars_as_map      = zipmap(local.env_vars_keys, local.env_vars_values)
  sorted_environment_vars = [
    for key in local.sorted_env_vars_keys :
    {
      name  = key
      value = lookup(local.env_vars_as_map, key)
    }
  ]
  final_environment = length(local.sorted_environment_vars) > 0 ? local.sorted_environment_vars : null

  init_container = var.init_image_name != "" ? [{
    name        = var.init_image_name
    image       = "${var.init_image_repository}:${var.init_image_tag}"
    essential   = false
    environment = local.final_environment
    secrets     = local.secrets
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = local.log_group_name
        awslogs-region        = var.region
        awslogs-stream-prefix = var.init_image_name
      }
  } }] : []
}

resource "random_string" "random_suffix" {
  length  = 3
  special = false
  upper   = false

  keepers = {
    # Generate a new id each time we switch to a new AMI id
    cluster_port = var.cluster_port
  }
}

#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = local.log_group_name
  retention_in_days = var.log_retention_days
}

data "aws_ecs_task_definition" "task" {
  task_definition = "${aws_ecs_task_definition.task.family}"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "${var.name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.cluster_task_execution_role_arn
  task_role_arn            = var.cluster_task_role_arn
  container_definitions = jsonencode(concat(local.init_container, [{
    name        = var.image_name
    image       = "${var.image_repository}:${var.image_tag}"
    essential   = true
    environment = local.final_environment
    secrets     = local.secrets
    portMappings = [{
      protocol      = "tcp"
      containerPort = var.cluster_port
      hostPort      = var.cluster_port
    }]
    healthCheck = var.container_health_check
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = local.log_group_name
        awslogs-region        = var.region
        awslogs-stream-prefix = var.image_name
      }
    }
    dependsOn = var.init_image_name != "" ? [{
      containerName = var.init_image_name
      condition     = "SUCCESS"
    }] : []
  }]))
}

resource "aws_ecs_service" "service" {
  name                               = "${var.name}-service"
  cluster                            = var.cluster_id
  task_definition                    = data.aws_ecs_task_definition.task.arn
  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 60
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
  force_new_deployment               = true

  network_configuration {
    security_groups  = var.cluster_security_groups
    subnets          = var.subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    container_name   = var.image_name
    container_port   = var.cluster_port
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "${var.name}-alb-target-group-${random_string.random_suffix.result}"
  port        = var.cluster_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled  = var.load_balancer_health_check.enabled
    port     = var.cluster_port
    protocol = var.load_balancer_health_check.protocol
    path     = var.load_balancer_health_check.path
    matcher  = var.load_balancer_health_check.matcher
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "security_group_rule" {
  type              = "ingress"
  from_port         = var.cluster_port
  to_port           = var.cluster_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.cluster_security_groups[0]
}

resource "aws_lb_listener_rule" "host_based_weighted_routing" {
  listener_arn = var.load_balancer_listener_arn
  priority     = var.alb_listener_rule_priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }

  condition {
    host_header {
      values = var.service_urls
    }
  }
}

resource "aws_appautoscaling_target" "service_target" {
  max_capacity       = var.max_count
  min_capacity       = var.min_count
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy_memory" {
  name               = "${var.name}-memory-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.service_target.resource_id
  scalable_dimension = aws_appautoscaling_target.service_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.service_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value = 80
  }
}

resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
  name               = "${var.name}-cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.service_target.resource_id
  scalable_dimension = aws_appautoscaling_target.service_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.service_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 60
  }
}

module "log_metric_error_filter" {
  count   = var.sns_alarm_topic_arn != "" ? 1 : 0
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-metric-filter"
  version = "~> 4.2.0"

  log_group_name = local.log_group_name

  name    = "ECS Service - Log Errors"
  pattern = "ERROR"

  metric_transformation_namespace = "LogMetrics"
  metric_transformation_name      = "ECSServiceErrorCount"
  metric_transformation_value     = "1"
}

module "log_metric_default_filter" {
  count   = var.sns_alarm_topic_arn != "" ? 1 : 0
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-metric-filter"
  version = "~> 4.2.0"

  log_group_name = local.log_group_name

  name    = "ECS Service - Log Default"
  pattern = ""

  metric_transformation_namespace = "LogMetrics"
  metric_transformation_name      = "ECSServiceErrorCount"
  metric_transformation_value     = "0"
}

module "metric_alarm_log_error" {
  count   = var.sns_alarm_topic_arn != "" ? 1 : 0
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 4.2.0"

  alarm_name          = "ECS Service - Error"
  alarm_description   = "Errors occured in the ECS Service"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = var.alarm_error_threshold
  period              = 300

  namespace   = "LogMetrics"
  metric_name = "ECSServiceErrorCount"
  statistic   = "Average"

  alarm_actions = [var.sns_alarm_topic_arn]
}

module "metric_alarm_cpu" {
  count   = var.sns_alarm_topic_arn != "" ? 1 : 0
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 4.2.0"

  alarm_name          = "ECS Service - CPU Usage High"
  alarm_description   = "CPU Usage Exceeds ${var.alarm_cpu_threshold}%"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = var.alarm_cpu_threshold
  period              = 300

  namespace   = "AWS/ECS"
  metric_name = "CPUUtilization"
  statistic   = "Average"

  dimensions = {
    ServiceName = "${var.name}-service",
    ClusterName = var.cluster_name
  }

  alarm_actions = [var.sns_alarm_topic_arn]
}

module "metric_alarm_memory" {
  count   = var.sns_alarm_topic_arn != "" ? 1 : 0
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 4.2.0"

  alarm_name          = "ECS Service - Memory Usage High"
  alarm_description   = "Memory Usage Exceeds ${var.alarm_memory_threshold}%"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = var.alarm_memory_threshold
  period              = 300

  namespace   = "AWS/ECS"
  metric_name = "MemoryUtilization"
  statistic   = "Average"

  dimensions = {
    ServiceName = "${var.name}-service",
    ClusterName = var.cluster_name
  }

  alarm_actions = [var.sns_alarm_topic_arn]
}