resource "aws_security_group" "alb_nginx_sg" {
  description = "ALB Security group about nginx."
  name        = "${var.project_name}-alb"
  vpc_id      = var.main_vpc_id
}

resource "aws_security_group_rule" "alb_nginx_sg_rule" {
  for_each          = { for k, v in var.alb_sg_rules : k => v }
  from_port         = each.value.from_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.alb_nginx_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  to_port           = each.value.to_port
  type              = each.value.type
}

resource "aws_security_group" "ecs_nginx_sg" {
  description = "ECS Security group about nginx."
  name        = "${var.project_name}-ecs"
  vpc_id      = var.main_vpc_id
}

resource "aws_security_group_rule" "ecs_nginx_sg_rule" {
  for_each                 = { for k, v in var.alb_sg_rules : k => v }
  from_port                = each.value.from_port
  protocol                 = each.value.protocol
  security_group_id        = aws_security_group.ecs_nginx_sg.id
  source_security_group_id = aws_security_group.alb_nginx_sg.id
  to_port                  = each.value.to_port
  type                     = each.value.type
}