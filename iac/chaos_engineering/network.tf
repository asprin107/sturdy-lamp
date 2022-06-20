module "network" {
  source = "git::https://github.com/asprin107/sturdy-lamp.git//iac/_module/network/public_only"

  rule = var.rule

  project_name = "chaos-engineering"
  region       = var.region
}