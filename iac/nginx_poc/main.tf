locals {
  profile = replace(var.TFC_WORKSPACE_NAME, "nginx_poc_", "")
  rule    = yamldecode(file("./resources/rule.yaml"))
  tags = {
    Owner   = "Kim, Youngsun"
    Email   = "tortoise@lguplus.co.kr"
    Account = local.profile
  }
}

module "network" {
  source = "./network"

  project_name = var.project_name
  rule         = local.rule

  tags = local.tags
}

module "service_ecs" {
  source     = "./service_ecs"
  depends_on = [module.network]

  main_vpc_id  = module.network.main_vpc_id
  project_name = var.project_name

  alb_subnet_ids = [for v in module.network.subnets_public : v.id]
  alb_sg_rules   = local.rule.security_group.nginx-alb

  tags = local.tags
}