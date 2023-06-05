module "common_infrastructure" {
  source = "./common"
}

module "eks_cluster" {
  source = "./eks"
}

output "key_id" {
  value = module.common_infrastructure.key_id
}

output "secret" {
  sensitive = true
  value     = module.common_infrastructure.secret
}