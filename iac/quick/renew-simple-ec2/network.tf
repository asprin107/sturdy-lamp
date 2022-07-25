module "network" {
  source = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/network/public_only"

  project_name = var.project
  region       = var.region
  tags         = module.tags
}

module "security_group" {
  source = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/security_group/cidr_only"

  vpc_id       = module.network.main_vpc_id
  project_name = var.project
  list_sg_rule = [
    {
      protocol    = "all"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      protocol    = "all"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  sg_description = "allow all for test"

  tags = module.tags.tags
}