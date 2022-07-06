locals {
  tags_basic_form = {
    account = var.aws_account
    env     = var.env
    project = var.project
    service = var.service
  }
}