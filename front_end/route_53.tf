locals {
  domain_name = "www.latin.com.ua"
}
resource "aws_route53_zone" "primary" {
  name = local.domain_name
}

resource "aws_route53_record" "front_end" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = local.domain_name
  type    = "A"

  alias {
    name                   = var.front_end_lb_dns_name
    zone_id                = var.back_end_lb_zone_id
    evaluate_target_health = true
  }
}