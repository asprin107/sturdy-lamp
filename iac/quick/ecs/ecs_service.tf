resource "aws_ecs_service" "haegol" {
  name    = local.naming_convention
  cluster = aws_ecs_cluster.main.arn

  task_definition = aws_ecs_task_definition.haegol.arn

  desired_count = 1

  deployment_controller {
    #   type = "CODE_DEPLOY"
    type = "ECS"
  }
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }

  network_configuration {
    subnets          = data.aws_subnets.pub_subnets.ids
    security_groups  = data.aws_security_groups.ecs.ids
    assign_public_ip = true
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 100
    base              = 0
  }
}