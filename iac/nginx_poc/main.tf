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