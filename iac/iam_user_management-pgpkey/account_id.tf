module "account_id-bmt" {
  source = "git::https://github.com/asprin107/sturdy-lamp.git//iac/_module/account_id"
  providers = {
    aws = aws.bmt
  }
}

module "account_id-dev" {
  source = "git::https://github.com/asprin107/sturdy-lamp.git//iac/_module/account_id"
  providers = {
    aws = aws.dev
  }
}