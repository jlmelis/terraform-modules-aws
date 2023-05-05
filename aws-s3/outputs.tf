output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

output "bucket_name" {
  value = var.bucket_name
}

output "bucket_region" {
  value = var.region
}

output "iam_access_key_id" {
  sensitive   = true
  value       = module.iam-s3-user.access_key_id
  description = "Access Key ID"
}

output "iam_secret_access_key" {
  sensitive   = true
  value       = module.iam-s3-user.secret_access_key
  description = "Secret Access Key. This will be written to the state file in plain-text"
}
