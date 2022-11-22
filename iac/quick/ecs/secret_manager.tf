resource "aws_secretsmanager_secret" "ecs" {
  name = "${local.naming_convention}-sm2"
}