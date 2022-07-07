module "lambda" {
  source = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/lambda/single_lambda_with_cicd"

  base_name              = ""
  lambda_description     = ""
  lambda_svc_policy_json = {}
  security_group_ids     = []
  subnet_ids             = []

  tags = module.tags.tags
}

module "tags" {
  source      = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/tags"
  aws_account = var.aws_account
  env         = var.env
  project     = var.project
  service     = var.service
}