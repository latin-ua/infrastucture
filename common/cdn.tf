# locals {
#   s3_origin_id = "myS3Origin"
# }

resource "aws_cloudfront_distribution" "latin_ua_distribution" {
  origin {
    domain_name = "frontend.latin.com.ua"
    origin_id   = "frontend"

    # s3_origin_config {
    #   origin_access_identity = aws_cloudfront_origin_access_identity.default.cloudfront_access_identity_path
    # }
  }
  enabled         = true
  is_ipv6_enabled = true

  # AWS Managed Caching Policy (CachingDisabled)
  default_cache_behavior {
    # Using the CachingDisabled managed policy ID:
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = "frontend"
    viewer_protocol_policy = "redirect-to-https"

  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

}