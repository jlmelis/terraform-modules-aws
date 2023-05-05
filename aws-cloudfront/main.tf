locals {
  s3_origin_id = "web_resources"
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI"
}

#tfsec:ignore:aws-cloudfront-enable-waf
resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {
    domain_name = var.web_resources_bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  aliases             = var.route53_domain_names
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = var.logs_bucket_domain_name #tfsec:ignore:aws-cloudfront-enable-logging
    prefix          = "log/cloudfront/"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true

    response_headers_policy_id = aws_cloudfront_response_headers_policy.web_security_headers_policy.id

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.sub_folder_routing.arn
    }
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 403
    response_code         = 200
    response_page_path    = "/404.html"
  }

  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 404
    response_code         = 200
    response_page_path    = "/404.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_function" "sub_folder_routing" {
  name    = "${var.project}-${var.environment}-cloudfront_sub_folder_routing"
  runtime = "cloudfront-js-1.0"
  publish = true
  code    = file("${path.module}/files/cloudfront_sub_folder_routing.js")
}

resource "aws_cloudfront_response_headers_policy" "web_security_headers_policy" {
  name = "${var.project}-${var.environment}-web-security-headers-policy"
  security_headers_config {
    content_type_options {
      override = true
    }
    frame_options {
      frame_option = "DENY"
      override     = true
    }
    referrer_policy {
      referrer_policy = "same-origin"
      override        = true
    }
    xss_protection {
      mode_block = true
      protection = true
      override   = true
    }
    strict_transport_security {
      access_control_max_age_sec = "63072000"
      include_subdomains         = true
      preload                    = true
      override                   = true
    }
    # TODO: should really try to remove unsafe-inline from the CSP
    content_security_policy {
      content_security_policy = "frame-ancestors 'none'; connect-src 'self'; default-src 'none'; font-src 'self' fonts.gstatic.com; img-src 'self' data:; media-src 'self'; manifest-src 'self'; script-src 'self' code.jquery.com 'unsafe-inline'; style-src 'self' fonts.googleapis.com 'unsafe-inline';"
      override                = true
    }
  }
}

data "aws_iam_policy_document" "web_resources_policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.web_resources_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "web_resources_policy" {
  bucket = var.web_resources_bucket_id
  policy = data.aws_iam_policy_document.web_resources_policy_document.json
}

resource "aws_route53_record" "cloudfront_distribution" {
  zone_id = var.route53_zone_id
  name    = ""
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudfront_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "apex_cloudfront_distribution" {
  count   = var.apex_alias ? 1 : 0
  zone_id = var.apex_dns_zone_id
  name    = ""
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudfront_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}