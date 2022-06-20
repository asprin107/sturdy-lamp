module "network" {
  source = "git::https://github.com/asprin107/sturdy-lamp.git//iac/_module/basic_network"

  project_name = "eks-test"
  region       = var.region
}