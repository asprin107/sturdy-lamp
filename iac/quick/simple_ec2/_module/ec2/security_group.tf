resource "aws_security_group" "public" {
  vpc_id      = var.vpc_id
  name        = "${var.project_name}-public-sg"
  description = "Allow public access"
}

resource "aws_security_group_rule" "allow_in_public_ssh" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.public.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "allow_in_public_spring-app" {
  from_port         = 0
  protocol          = "tcp"
  security_group_id = aws_security_group.public.id
  to_port           = 0
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "allow_out_all" {
  from_port         = 0
  protocol          = "all"
  security_group_id = aws_security_group.public.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}