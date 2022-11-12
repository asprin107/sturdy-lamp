resource "aws_security_group" "sg" {
  vpc_id      = var.vpc_id
  name        = "${var.security_group_name}-sg"
  description = var.sg_description
  tags = merge(
    var.tags,
    {
      Name = "sg-${var.security_group_name}"
    }
  )
}

# protocol, from_port, to_port, type, cidr_blocks
resource "aws_security_group_rule" "sg_rule" {
  for_each          = { for v in var.list_sg_rule : "${v.type}_${v.protocol}_${v.from_port}_${v.cidr_blocks[0]}" => v }
  security_group_id = aws_security_group.sg.id
  description       = each.value.description # description for
  protocol          = each.value.protocol    # tcp or udp, "all" to all, "-1" to all
  from_port         = each.value.from_port   # 0 to all
  to_port           = each.value.to_port     # 0 to all
  type              = each.value.type        # ingress or egress
  cidr_blocks       = each.value.cidr_blocks
}