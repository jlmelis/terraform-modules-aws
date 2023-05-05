data "aws_caller_identity" "current" {}

#tfsec:ignore:aws-s3-enable-versioning
resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = true
  restrict_public_buckets = true
}

module "iam-s3-user" {
  source  = "cloudposse/iam-s3-user/aws"
  version = "1.1.0"

  stage = var.environment
  name  = var.bucket_name
  s3_actions = [
    "s3:*"
  ]
  s3_resources = ["${aws_s3_bucket.bucket.arn}/*"]
}