module "simple-ec2" {
  source = "./_module/ec2"
  count  = length(local.ec2_info)

  project_name  = local.ec2_info[count.index].project_name
  subject_name  = local.ec2_info[count.index].subject_name
  subnet_id     = data.aws_subnets.instance_deployed.ids[(count.index + 1) % length(data.aws_subnets.instance_deployed.ids)]
  instance_type = "t3.medium"
  ami           = data.aws_ssm_parameter.default.value
  key_name      = "simple-ec2"

  instance_sg_ids = [aws_security_group.public.id]
}

module "key" {
  source = "../../_module/private-key"
}

module "ec2-key" {
  source = "../../_module/ec2/key_pair"

  ec2_pub_key = module.key.rsa-pub-key
  key_name    = "simple-ec2"
}