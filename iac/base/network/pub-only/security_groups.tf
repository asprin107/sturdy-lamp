module "sg" {
  source = "../../../_module/security_group/cidr_only"

  for_each = local.list_sg

  list_sg_rule        = each.value.rules
  security_group_name = each.key
  sg_description      = each.value.description
  tags                = module.default_tags.tags
  vpc_id              = module.network.main_vpc_id
}