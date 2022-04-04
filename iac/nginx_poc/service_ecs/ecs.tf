# TODO ECS Service

locals {
  ecs_name = "${var.project_name}-ecs"
}

resource "aws_ecs_cluster" "main" {
  name = var.project_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(
    {
      Name = local.ecs_name
    }
  )
}
resource "aws_ecs_cluster_capacity_providers" "ecs_main_capacity" {
  cluster_name = aws_ecs_cluster.main.name
  #  capacity_providers = [
  #    "FARGATE",
  #    "FARGATE_SPOT"
  #  ]
}

resource "aws_ecs_task_definition" "nginx" {
  container_definitions = var.container_def
  family                = "${local.ecs_name}-task"

  cpu    = "1024"
  memory = "2048"

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  ipc_mode                 = "task"
  pid_mode                 = "task"

  task_role_arn      = aws_iam_role.nginx_task.arn
  execution_role_arn = aws_iam_role.nginx_task_execution.arn

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

  ephemeral_storage {
    size_in_gib = 21
  }
}