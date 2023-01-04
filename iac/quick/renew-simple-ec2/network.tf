module "network" {
  source = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/network/public_only"

  project_name = var.project
  region       = var.region
  tags         = module.tags.tags
}

module "security_group" {
  source = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/security_group/cidr_only"

  vpc_id              = module.network.main_vpc_id
  security_group_name = "ec2-sg"

  list_sg_rule = [
    {
      description = "Allow inbound all."
      protocol    = "all"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow outbound all."
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