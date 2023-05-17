module "s3" {
  source = "../_module/s3/general"

  tags = module.tags.tags
}