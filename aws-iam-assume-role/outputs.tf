output "iam_role_arn" {
  description = "The ARN of IAM role"
  value       = aws_iam_role.role.arn
}
