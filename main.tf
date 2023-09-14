module "common_infrastructure" {
  source = "./common"
  get_translation_method_url = module.back_end_lambda.get_translation_methods_url
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
  source = "./front_end"
}

module "back_end_lambda" {
  source = "./back_end_lambda"
}

output "key_id" {
  value = module.common_infrastructure.key_id
}

output "secret" {
  sensitive = true
  value     = module.common_infrastructure.secret
}

output "frontend_bucket_url" {
  value = module.front_end.frontend_bucket_url
}
