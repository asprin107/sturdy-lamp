output "network" {
  description = "Result of created network resources."
  value = {
    vpc_id          = module.network.main_vpc_id
    subnets_public  = module.network.subnets_public
    subnets_private = module.network.subnets_private
  }
}

output "naming" {
  description = "Object associated with naming convention."
  value = {
    name          = module.naming.name
    random_string = module.naming.random_string
  }
}