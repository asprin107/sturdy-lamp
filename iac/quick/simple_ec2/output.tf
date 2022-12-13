output "vpc_id" {
  value = module.network.main_vpc_id
}

output "public_subnet_ids" {
  value = module.network.list_public_subnet
}

output "ec2_public_ip" {
  value = module.simple-ec2.public_ip
}