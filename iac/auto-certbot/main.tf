locals {
  profile = replace(var.TFC_WORKSPACE_NAME, "auto-certbot-", "")
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

module "instance" {
  source = "./instance"

  PUB_KEY          = var.PUB_KEY
  ami              = "ami-03d79d440297083e3" # amazonlinux2
#  ami              = "ami-003e89ec577120c95" # centos 7.9
#  ami              = "ami-002ff252a6428b3d1" # centos 7.4
  project_name     = var.project_name
  public_sbn_id    = module.network.subnets_public[0].id
  public_web_sg_id = module.network.security_group.id
  type             = "t3.medium"
}