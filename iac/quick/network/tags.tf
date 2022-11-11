module "default_tags" {
  source = "../../_module/tags"

  aws_account = var.aws_account
  env         = var.env
  project     = var.project
  service     = var.service
}