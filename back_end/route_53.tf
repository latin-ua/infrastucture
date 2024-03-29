locals {
  domain_name     = "api.latin.com.ua"
  public_dns_zone = "latin.com.ua"
}
resource "aws_route53_zone" "primary" {
  name = local.public_dns_zone
}

resource "aws_route53_record" "back_end" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = local.domain_name
  type    = "A"

  alias {
    name                   = var.back_end_lb_dns_name
    zone_id                = var.back_end_lb_zone_id
    evaluate_target_health = true
  }
}