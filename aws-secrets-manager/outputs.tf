output "secrets" {
  value = tomap({
    for key, value in var.secrets : key => "${aws_secretsmanager_secret.secret.arn}:${key}::"
  })
}