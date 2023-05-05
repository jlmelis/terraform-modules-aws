resource "aws_lb" "alb" {
  name                       = "${var.name}-alb"
  internal                   = false #tfsec:ignore:aws-elb-alb-not-public
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb.id]
  subnets                    = var.subnet_ids
  drop_invalid_header_fields = true

  // TODO: enable access logs
  # access_logs {
  #   bucket  = aws_s3_bucket.logs.bucket
  #   prefix  = "log/alb"
  #   enabled = true
  # }
}

resource "aws_security_group" "alb" {
  name        = "${var.name}-lb-sg"
  description = "Allow ALB inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow ALB inbound traffic on port 80"
    protocol    = "tcp"
    from_port   = var.http_port
    to_port     = var.http_port
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-ingress-sgr
  }

  ingress {
    description = "Allow ALB inbound traffic on port 443"
    protocol    = "tcp"
    from_port   = var.https_port
    to_port     = var.https_port
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-ingress-sgr
  }

  egress {
    description = "Allow outbound traffic from ALB to internet"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-egress-sgr
  }
}

resource "aws_alb_target_group" "alb" {
  name        = "${var.name}-alb-target"
  port        = var.http_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold = "3"
    interval          = "30"
    protocol          = "HTTP"
    matcher           = "200"
    timeout           = "5"
    path              = var.health_check_path
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.alb.id
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = var.https_port
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_lb.alb.id
  port              = var.https_port
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn = var.certificate_arn

  default_action {
    target_group_arn = aws_alb_target_group.alb.id
    type             = "forward"
  }
}

resource "aws_alb_listener_certificate" "alternate" {
  listener_arn    = aws_alb_listener.https.arn
  certificate_arn = var.certificate_arn
}

# A records for alb
resource "aws_route53_record" "alb" {
  for_each = toset(var.dns_record_names)

  provider = aws.dns_zone_account
  zone_id  = var.dns_zone_id
  name     = each.value
  type     = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = false
  }
}

module "metric_alarm" {
  count   = var.sns_alarm_topic_arn != "" ? 1 : 0
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 4.2.0"

  alarm_name          = "ELB - Unhealthy Host Check"
  alarm_description   = "Host is Unhealthy"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = var.alarm_unheathly_threshold
  period              = 60
  unit                = "Count"

  namespace   = "AWS/ApplicationELB"
  metric_name = "UnHealthyHostCount"
  statistic   = "Average"

  dimensions = {
    LoadBalancer = aws_lb.alb.arn_suffix,
    TargetGroup  = aws_alb_target_group.alb.arn_suffix
  }

  alarm_actions = [var.sns_alarm_topic_arn]
}
