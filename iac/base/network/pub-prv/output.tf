output "network" {
  description = "Result of created network resources."
  value = {
    vpc_id             = module.network.main_vpc_id
    public_subnet_ids  = module.network.public_subnet_ids
    private_subnet_ids = module.network.private_subnet_ids
  }
}

output "naming" {
  description = "Object associated with naming convention."
  value = {
    name          = module.naming.name
    random_string = module.naming.random_string
  }
}