resource "aws_security_group" "public_web" {
  vpc_id      = aws_vpc.main.id
  name        = "public-web"
  description = "Allow public access from all"
}

resource "aws_security_group_rule" "allow_in_public_ssh" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.public_web.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "allow_in_public_web" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.public_web.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "allow_in_public_https" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.public_web.id
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "allow_in_public_spring-app" {
  from_port         = 8080
  protocol          = "tcp"
  security_group_id = aws_security_group.public_web.id
  to_port           = 8080
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "allow_out_all" {
  from_port         = 0
  protocol          = "all"
  security_group_id = aws_security_group.public_web.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}