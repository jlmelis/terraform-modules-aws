module "metric_alarm" {
  count   = var.sns_alarm_topic_arn != "" ? 1 : 0
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 4.2.0"

  alarm_name          = "Billing - Exceeded Monthly Budget"
  alarm_description   = "Exceeded Monthly Budget"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = var.alarm_cost_threshold
  period              = 21600

  namespace   = "AWS/Billing"
  metric_name = "EstimatedCharges"
  statistic   = "Maximum"

  dimensions = {
    Currency = "USD"
  }

  alarm_actions = [var.sns_alarm_topic_arn]
}
