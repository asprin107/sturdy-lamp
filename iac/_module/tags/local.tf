locals {
  tags_basic_form = {
    Project     = var.project
    Service     = var.service
    Management  = "terraform"
    Environment = var.env
    Account     = var.aws_account
  }
}