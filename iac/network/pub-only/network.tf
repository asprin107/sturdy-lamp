module "network" {
  source = "../../_module/network/public_only"

  project_name = var.project
  region       = var.region

  map_public_ip_on_launch = true

  tags     = module.default_tags.tags
  eks_tags = module.eks_tags.tags
}