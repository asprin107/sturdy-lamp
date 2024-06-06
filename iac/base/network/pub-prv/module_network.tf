module "network" {
  source = "../../../_module/network/v1-alpha"

  name   = module.naming.name
  region = var.region
}