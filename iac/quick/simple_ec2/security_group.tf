resource "aws_security_group" "public" {
  vpc_id      = data.aws_vpc.main.id
  name        = "public-simple-ec2-sg"
  description = "Allow public access"
}

resource "aws_security_group_rule" "allow_in_public_spring-app" {
  from_port         = 8080
  protocol          = "tcp"
  security_group_id = aws_security_group.public.id
  to_port           = 8080
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "allow_in_public_grafana" {
  from_port         = 3000
  protocol          = "tcp"
  security_group_id = aws_security_group.public.id
  to_port           = 3000
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "allow_in_public_influxdb" {
  from_port         = 8086
  protocol          = "tcp"
  security_group_id = aws_security_group.public.id
  to_port           = 8086
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