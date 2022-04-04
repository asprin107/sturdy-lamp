# TODO ECS Task
# TODO ECS Service

locals {
  ecs_name = "${var.project_name}-ecs"
}

resource "aws_ecs_cluster" "main" {
  name = var.project_name

  tags = merge(
    {
      Name = local.ecs_name
    }
  )
}