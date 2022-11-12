module "network" {
  source = "../../_module/network/public_only"

  project_name = var.project
  region       = var.region

  tags = module.default_tags.tags
}