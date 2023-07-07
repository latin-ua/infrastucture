module "common_infrastructure" {
  source = "./common"
}

module "eks_cluster" {
  source = "./eks"
}

module "back_end" {
  source               = "./back_end"
  back_end_lb_dns_name = var.back_end_lb_dns_name
  back_end_lb_zone_id  = var.back_end_lb_zone_id
}

module "front_end" {
  source                = "./front_end"
  front_end_lb_dns_name = var.front_end_lb_dns_name
  front_end_lb_zone_id  = var.front_end_lb_zone_id
}

output "key_id" {
  value = module.common_infrastructure.key_id
}

output "secret" {
  sensitive = true
  value     = module.common_infrastructure.secret
}