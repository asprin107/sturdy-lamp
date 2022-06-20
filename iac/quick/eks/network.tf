module "network" {
  source = "git::https://github.com/asprin107/sturdy-lamp.git//iac/_module/network/basic"

  project_name = "eks-test"
  region       = var.region
}