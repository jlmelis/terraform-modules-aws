output "bucket_id" {
  value = aws_s3_bucket.web_resources.id
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.web_resources.bucket_regional_domain_name
}

output "bucket_arn" {
  value = aws_s3_bucket.web_resources.arn
}