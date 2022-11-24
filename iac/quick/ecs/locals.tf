locals {
  naming_convention      = "${var.project}-${var.service}-${var.env}"
  haegol_ecs_task_origin = jsondecode(file("./resources/haegol-definition.json"))

  alb_name = "${var.project}-alb"

  ecs_envs = {
    "secrets" : [
      { "name" : "POSTGRES_USER", "valueFrom" : "${aws_secretsmanager_secret.ecs.arn}:POSTGRES_USER::" },
      { "name" : "POSTGRES_PASSWORD", "valueFrom" : "${aws_secretsmanager_secret.ecs.arn}:POSTGRES_PASSWORD::" },
      { "name" : "POSTGRES_DB", "valueFrom" : "${aws_secretsmanager_secret.ecs.arn}:POSTGRES_DB::" }
    ]
  }

  haegol_ecs_task_def = concat(
    [
      local.haegol_ecs_task_origin[0]
    ],
    [
      merge(local.haegol_ecs_task_origin[1], local.ecs_envs)
    ]
  )
}