output "security_groups" {
  value = [aws_security_group.alb.id]
}

output "target_group_arn" {
  value = aws_alb_target_group.alb.id
}

output "load_balancer_arn" {
  value = aws_lb.alb.id
}

output "https_listener_arn" {
  value = aws_alb_listener.https.arn
}