data "aws_caller_identity" "current" {}

#tfsec:ignore:aws-s3-enable-versioning
resource "aws_s3_bucket" "web_resources" {
  bucket        = "${var.project}-${var.environment}-web-resources-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "web_resources" {
  bucket = aws_s3_bucket.web_resources.id
  acl    = "private"
}

#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "web_resources" {
  bucket = aws_s3_bucket.web_resources.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "web_resources" {
  bucket = aws_s3_bucket.web_resources.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "web_resources" {
  bucket = aws_s3_bucket.web_resources.id

  target_bucket = var.logs_bucket_id
  target_prefix = "log/web_resources/"
}

