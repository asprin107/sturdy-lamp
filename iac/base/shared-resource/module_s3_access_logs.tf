module "s3_access_logs" {
  source = "../../_module/s3/access-logs"

  alb_name = []

  tags = module.default_tags.tags
}