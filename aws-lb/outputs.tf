output "load_balancer_arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.lb.arn
}

output "lb_security_group_id" {
  value = var.security_group_id
}