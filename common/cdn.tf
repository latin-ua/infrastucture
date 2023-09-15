locals {
  zone_id            = "Z015263031Q4FAY12JMRL"
  primary_domain     = "latin.com.ua"
  alternative_domain = "www.${local.primary_domain}"
}

resource "aws_cloudfront_distribution" "latin_ua_distribution" {

  origin {
    domain_name              = "frontend-991225504892.s3.eu-central-1.amazonaws.com"
    origin_access_control_id = aws_cloudfront_origin_access_control.frontend.id
    origin_id                = "frontend"
  }

  aliases = [local.primary_domain, local.alternative_domain]

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"

  }

  # AWS Managed Caching Policy (CachingDisabled)
  default_cache_behavior {
    # Using the CachingDisabled managed policy ID:
    cache_policy_id          = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    allowed_methods          = ["GET", "HEAD", "OPTIONS"]
    cached_methods           = ["GET", "HEAD", "OPTIONS"]
    target_origin_id         = "frontend"
    viewer_protocol_policy   = "redirect-to-https"
    origin_request_policy_id = "b689b0a8-53d0-40ab-baf2-68738e2966ac"

  }

  origin {
    domain_name = replace(replace(var.get_translation_method_url, "https://", ""), "/", "")
    origin_id   = "backend_lambda"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern             = "/api/translation-methods"
    cache_policy_id          = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    allowed_methods          = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods           = ["GET", "HEAD", "OPTIONS"]
    target_origin_id         = "backend_lambda"
    origin_request_policy_id = "b689b0a8-53d0-40ab-baf2-68738e2966ac"
    viewer_protocol_policy   = "redirect-to-https"
  }

  origin {
    domain_name = "api.${local.primary_domain}"
    origin_id   = "backend"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern             = "/api/*"
    cache_policy_id          = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    allowed_methods          = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods           = ["GET", "HEAD", "OPTIONS"]
    target_origin_id         = "backend"
    origin_request_policy_id = "b689b0a8-53d0-40ab-baf2-68738e2966ac"
    viewer_protocol_policy   = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["RU"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = aws_acm_certificate.cdn_certificate.arn
    ssl_support_method             = "sni-only"
  }

}

resource "aws_route53_record" "cdn_main" {
  zone_id = local.zone_id
  name    = local.primary_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.latin_ua_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.latin_ua_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "cdn_alternative" {
  zone_id = local.zone_id
  name    = local.alternative_domain
  type    = "CNAME"
  ttl     = 3600
  records = [aws_route53_record.cdn_main.fqdn]

}

resource "aws_acm_certificate" "cdn_certificate" {
  domain_name               = local.primary_domain
  subject_alternative_names = [local.alternative_domain]
  validation_method         = "DNS"
  provider                  = aws.US

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "domain_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cdn_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = local.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_cloudfront_origin_access_control" "frontend" {
  name                              = "frontend-access"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
