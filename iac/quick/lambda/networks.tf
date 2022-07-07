module "network" {
  source = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/network/public_only"

  project_name = var.project
  region       = var.region
}