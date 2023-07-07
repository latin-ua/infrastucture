locals {
  domain_name = "www.latin.com.ua"
}

resource "aws_route53_record" "front_end" {
  zone_id = "Z015263031Q4FAY12JMRL"
  name    = local.domain_name
  type    = "A"

  alias {
    name                   = var.front_end_lb_dns_name
    zone_id                = var.front_end_lb_zone_id
    evaluate_target_health = true
  }
}
