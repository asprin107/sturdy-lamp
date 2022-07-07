module "lambda" {
  source = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/lambda/single_lambda_with_cicd"

  base_name              = "${var.aws_account}-${var.project}-${var.service}-${var.env}"
  lambda_description     = "This lambda for test"
  lambda_svc_policy_json = data.aws_iam_policy_document.lambda_svc_policy.json
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