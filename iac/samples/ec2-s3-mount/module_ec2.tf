module "ec2" {
  source = "../../_module/ec2/instance-static_ip"

  instance_type = var.ec2.instance_type
  key_name      = var.ec2.key_name
  list_sg       = var.ec2.list_sg
  subnet_id     = var.ec2.subnet_id

  instance_profile_name = module.s3.ec2_role.instance_profile_name

  user_data_base64 = base64encode(module.s3.ec2_linux_goofys_userdata)

  tags = module.tags.tags
}