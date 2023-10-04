module "s3" {
  source = "../../_module/s3/mountable"

  s3_vpc_id     = var.s3_vpc_id
  s3_subnet_ids = [var.ec2.subnet_id]
  aws_region    = var.aws_region
  #  route_table_id = var.route_table_id
  local_mount_path = var.local_mount_path

  s3_prefix = var.s3_prefix

  tags = module.tags.tags
}