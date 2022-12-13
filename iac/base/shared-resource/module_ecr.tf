module "ecr" {
  source   = "../../_module/ecr"
  for_each = { for k, v in local.list_ecr : v.service_name => v }

  image_tag_mutability = each.value.image_tag_mutability
  scan_on_push         = each.value.scan_on_push
  service_name         = each.value.service_name

  tags = merge(
    module.default_tags.tags,
    {
      Service = each.value.service_name
    }
  )
}