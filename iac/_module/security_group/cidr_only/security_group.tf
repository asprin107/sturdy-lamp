resource "aws_security_group" "sg" {
  vpc_id      = var.vpc_id
  name        = "${var.project_name}-sg"
  description = var.sg_description
  tags = merge(
    var.tags,
    {
      Name = "sg-${var.project_name}"
    }
  )
}

# protocol, from_port, to_port, type, cidr_blocks
resource "aws_security_group_rule" "sg_rule" {
  for_each          = { for v in var.list_sg_rule : "${v.protocol}_${v.type}_${v.cidr_blocks[0]}_${v.from_port}" => v }
  security_group_id = aws_security_group.sg.id
  protocol          = each.value.protocol  # tcp or udp
  from_port         = each.value.from_port # 0 to all
  to_port           = each.value.to_port   # 0 to all
  type              = each.value.type      # ingress or egress
  cidr_blocks       = each.value.cidr_blocks
}