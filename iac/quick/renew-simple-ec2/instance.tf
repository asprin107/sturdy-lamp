module "ec2" {
  source = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/ec2/instance-static_ip"

  ami              = "ami-002e2b2b1334aaf55" # aws ec2 describe-images --owners amazon --filters Name="description",Values="Amazon Linux 2*" Name="architecture",Values="x86_64" --output table
  instance_type    = "t3.medium"
  key_name         = var.ec2-key-name
  list_sg          = [module.security_group.list_security_group.id]
  project_name     = var.project
  subject_name     = var.service
  subnet_id        = module.network.list_public_subnet[0].id
  root_volume_size = "50"

  depends_on = [module.ec2-key]
}