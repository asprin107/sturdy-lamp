module "network" {
  source = "../../../_module/network/v1-alpha"

  name   = module.naming.name
  region = var.region

  rule = {
    host_cidr = "10.0.0.0/16"
    subnets = {
      newbits         = 6
      available_zones = ["a", "c"]
      pub = {
        amount = 2
        max    = 20
      }
      prv = {
        amount = 0
        max    = 44
      }
    }
  }
}