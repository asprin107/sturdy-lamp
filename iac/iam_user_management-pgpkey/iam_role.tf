module "iam_role-bmt" {
  for_each = local.list_common_iam_role
  source   = "git::https://github.com/asprin107/sturdy-lamp.git//iac/_module/iam/iam-role-managed-policy-only"
  providers = {
    aws = aws.bmt
  }

  role_name          = "${local.iam_role_name_prefix}_bmt_${each.key}"
  list_role_policies = each.value

  list_user_arn_allowed_assume = concat(
    [
      for obj in local.list_user_json :
      "arn:aws:iam::${local.list_aws_accounts.bmt}:user/users/${obj.org}/${obj.id}"
      if(lookup(obj.permission_type, "bmt", "") == each.key)
    ],
    ["arn:aws:iam::${local.list_aws_accounts.bmt}:root"]
  )

  tags = merge(module.tags["bmt"].tags_default,
    {
      Owner = "bmt"
  })
}


module "iam_role-dev" {
  for_each = local.list_common_iam_role
  source   = "git::https://github.com/asprin107/sturdy-lamp.git//iac/_module/iam/iam-role-managed-policy-only"
  providers = {
    aws = aws.dev
  }

  role_name          = "${local.iam_role_name_prefix}_dev_${each.key}"
  list_role_policies = each.value

  list_user_arn_allowed_assume = concat(
    [
      for obj in local.list_user_json :
      "arn:aws:iam::${local.list_aws_accounts.bmt}:user/users/${obj.org}/${obj.id}"
      if(lookup(obj.permission_type, "dev", "") == each.key)
    ],
    ["arn:aws:iam::${local.list_aws_accounts.bmt}:root"]
  )

  tags = merge(module.tags["dev"].tags_default,
    {
      Owner = "dev"
  })
}