resource "aws_ecs_service" "haegol" {
  name    = local.naming_convention
  cluster = aws_ecs_cluster.main.arn

  task_definition = aws_ecs_task_definition.haegol.arn

  launch_type = "EC2"

  desired_count = 1

  load_balancer {
    container_name   = "haegol"
    container_port   = 8080
    target_group_arn = aws_alb_target_group.alb_http_tg_1.arn
  }

  ordered_placement_strategy {
    type  = "spread" # random / spread / binpack
    field = "attribute:ecs.availability-zone"
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  deployment_controller {
    type = "CODE_DEPLOY" # ECS / CODE_DEPLOY
  }
  #  deployment_circuit_breaker {
  #    enable   = false
  #    rollback = false
  #  }

  network_configuration {
    subnets          = data.aws_subnets.pub_subnets.ids
    security_groups  = data.aws_security_groups.ecs.ids
    assign_public_ip = false # false for launch_type: EC2
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer # Target changed by CodeDeploy
    ]
  }
}