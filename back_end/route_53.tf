locals {
  domain_name = "latin.com.ua"
}
resource "aws_route53_zone" "primary" {
  name = local.domain_name
}

resource "aws_route53_record" "back_end" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = local.domain_name
  type    = "A"

  alias {
    name = var.back_end_lb_dns_name
    zone_id = var.back_end_lb_zone_id
    # name                   = "k8s-default-latinuab-6a15ee9c87-1080738667.eu-central-1.elb.amazonaws.com"
    # zone_id                = "Z215JYRZR1TBD5"
    evaluate_target_health = true
  }
}