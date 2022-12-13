module "tags" {
  source = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/tags"

  aws_account = var.aws_account
  env         = var.env
  project     = var.project
  service     = var.service
}