module "iam_user" {
  for_each = local.list_user
  source   = "git::https://github.com/asprin107/sturdy-lamp.git//iac/_module/iam/iam-user-pgpkey"
  providers = {
    aws = aws.bmt
  }

  user_name      = each.key
  path           = "/users/${each.value.org}/"
  mfa_policy_arn = module.iam_policy_mfa.policy_arn

  list_role_arn_allowed_assume = [
    for k, v in each.value.permission_type :
    "arn:aws:iam::${lookup(local.list_aws_accounts, "${k}")}:role/users/${local.iam_role_name_prefix}_${k}_${v}"
    if(v != "" && v != null)
  ]
  list_directly_attached_managed_policy = each.value.permission_set

  list_allowed_ip = each.value.ip_restriction.personal_ips
}

module "iam_policy_mfa" {
  source = "git::https://github.com/asprin107/sturdy-lamp.git//iac/_module/iam/iam-policy-mfa"
  providers = {
    aws = aws.bmt
  }
}