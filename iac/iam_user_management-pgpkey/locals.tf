locals {
  list_aws_accounts = tomap({
    "bmt" = module.account_id-bmt.account_id # sandbox account.
    "dev" = module.account_id-dev.account_id # develop account.
  })

  permissions_definition_yaml = yamldecode(file("./_resources/permissions_definition.yaml"))
  list_common_iam_role        = { for k, v in local.permissions_definition_yaml.permission_type : k => v }

  list_user_json = jsondecode(file("./_resources/list_user_json.json"))
  list_user      = { for obj in local.list_user_json : obj.id => obj }

  iam_role_name_prefix = "iam_assume_role"
}