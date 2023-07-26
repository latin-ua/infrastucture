locals {
  domain_name = "latin.com.ua"
  zone_id     = "Z015263031Q4FAY12JMRL"
}

resource "aws_route53_record" "front_end" {
  zone_id = local.zone_id
  name    = local.domain_name
  type    = "A"

  alias {
    name                   = var.front_end_lb_dns_name
    zone_id                = var.front_end_lb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "front_end_alternative" {
  zone_id = local.zone_id
  name    = "www.latin.com.ua"
  type    = "CNAME"
  records = [local.domain_name]
  ttl     = 60
}
