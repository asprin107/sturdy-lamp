data "aws_secretsmanager_secret" "env" {
  name = "${var.project}-${var.env}-ecs_haegol"
}