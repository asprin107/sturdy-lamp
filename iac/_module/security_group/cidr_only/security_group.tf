resource "aws_security_group" "sg" {
  vpc_id      = var.vpc_id
  name        = "sg-${var.project_name}"
  description = var.sg_description
}

# protocol, from_port, to_port, type, cidr_blocks
resource "aws_security_group_rule" "sg_rule" {
  for_each          = var.list_sg_rule
  security_group_id = aws_security_group.sg.id
  protocol          = each.value.protocol  # tcp or udp
  from_port         = each.value.from_port # -1 to all
  to_port           = each.value.to_port   # -1 to all
  type              = each.value.type      # ingress or egress
  cidr_blocks       = each.value.cidr_blocks
}