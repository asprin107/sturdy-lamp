resource "aws_security_group" "asg_node_group" {
  name        = var.ecs_asg.launch_template.sg_name
  description = var.ecs_asg.launch_template.sg_description
  vpc_id      = data.aws_vpc.main.id

  dynamic "ingress" {
    for_each = { for v in var.ecs_asg.launch_template.sg_rules : v.name => v if v.type == "ingress" }
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = { for v in var.ecs_asg.launch_template.sg_rules : v.name => v if v.type == "egress" }
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}