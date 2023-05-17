# Jmeter Client (MS-window, GUI needed)
module "jmeter-client" {
  source = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/ec2/instance-static_ip"

  ami                   = data.aws_ssm_parameter.jmeter-client-ami.value
  instance_type         = "t3.large"
  key_name              = var.ec2-key-name
  list_sg               = [module.security_group.list_security_group.id]
  project_name          = var.project
  subject_name          = format("%s-%s", var.service, "client")
  subnet_id             = module.network.pub_subnet_ids[0]
  instance_profile_name = aws_iam_instance_profile.ec2.name
  root_volume_size      = "50"

  user_data_base64 = base64encode(file("./user_data_leader.yaml"))

  depends_on = [module.ec2-key]
}

# Jmeter Server (Linux)
module "jmeter-server" {
  source = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/ec2/instance-static_ip"
  count  = var.worker-node-amount

  ami                   = data.aws_ssm_parameter.jmeter-server-ami.value
  instance_type         = "t3.medium"
  key_name              = var.ec2-key-name
  list_sg               = [module.security_group.list_security_group.id]
  project_name          = var.project
  subject_name          = format("%s-%s-%02d", var.service, "server", count.index + 1)
  subnet_id             = module.network.pub_subnet_ids[count.index % length(module.network.pub_subnet_ids)]
  instance_profile_name = aws_iam_instance_profile.ec2.name
  root_volume_size      = "50"

  user_data_base64 = base64encode(file("./user_data_worker.sh"))

  depends_on = [module.ec2-key, module.jmeter-client]
}