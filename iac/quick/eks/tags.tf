module "default_tags" {
  source = "../../_module/tags"

  aws_profile = var.aws_account
  env         = var.env
  project     = var.project
  service     = var.service
}