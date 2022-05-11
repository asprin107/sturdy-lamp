module "network" {
  source = "./_module/basic-network"

  project_name = "simple-ec2"
  region       = var.region
  rule         = yamldecode(file("./simple-ec2-network-rule.yaml"))
}

module "simple-ec2" {
  source = "./_module/ec2"

  project_name  = "simple-ec2"
  subject_name  = "test"
  vpc_id        = module.network.main_vpc_id
  subnet_id     = module.network.list_public_subnet[0].id
  instance_type = "t3.medium"
  ami           = var.ami
  ec2_pub_key   = var.ec2_pub_key
}