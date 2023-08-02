resource "aws_acm_certificate" "front_end_lb_certificate" {
  domain_name       = aws_route53_record.front_end.fqdn
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

#resource "aws_route53_record" "domain_validation" {
#  for_each = {
#    for dvo in aws_acm_certificate.front_end_lb_certificate.domain_validation_options : dvo.domain_name => {
#      name   = dvo.resource_record_name
#      record = dvo.resource_record_value
#      type   = dvo.resource_record_type
#    }
#  }
#
#  zone_id = local.zone_id
#  name    = each.value.name
#  type    = each.value.type
#  records = [each.value.record]
#  ttl     = 60
#}
