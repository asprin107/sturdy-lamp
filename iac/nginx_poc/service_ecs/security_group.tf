resource "aws_security_group" "alb_nginx_sg" {
  description = "ALB Security group about nginx."
  name        = "${var.project_name}-alb"

  tags = var.tags
}

resource "aws_security_group_rule" "alb_nginx_sg_rule" {
  for_each          = [for k, v in var.alb_sg_rules : v]
  from_port         = each.value.from_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.alb_nginx_sg
  to_port           = each.value.to_port
  type              = each.value.type
}