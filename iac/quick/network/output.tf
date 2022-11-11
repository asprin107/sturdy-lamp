output "vpc_id" {
  value = module.network.main_vpc_id
}

output "pub_subnets" {
  value = module.network.pub_subnet_ids
}