module "secrets_manager" {
  source = "../../_module/secrets_manager"

  for_each = { for k, v in local.list_secrets_manager : v.purpose => v }

  purpose          = each.key
  description      = each.value.description
  maintenance_date = each.value.recovery_window_in_days

  tags = module.default_tags.tags
}