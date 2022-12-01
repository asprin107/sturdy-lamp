resource "aws_ecs_task_definition" "haegol" {
  container_definitions = jsonencode(local.haegol_ecs_task_def)
  family                = "haegol"

  cpu    = "2048"
  memory = "4096"

  requires_compatibilities = [
    "FARGATE",
    "EC2"
  ]
  network_mode = "awsvpc"
  #  ipc_mode                 = "task" # does't support for Fargate
  #  pid_mode                 = "task" # does't support for Fargate

  task_role_arn      = aws_iam_role.ecs_task.arn
  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  runtime_platform {
    cpu_architecture        = "ARM64" # X86_64 / ARM64
    operating_system_family = "LINUX"
  }

  # Available for Fargate only.
  #  ephemeral_storage {
  #    size_in_gib = 25
  #  }

  # NOTE only used for creation.
  lifecycle {
    create_before_destroy = true
  }
}