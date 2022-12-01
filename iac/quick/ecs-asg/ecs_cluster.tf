resource "aws_ecs_cluster" "main" {
  name = local.naming_convention

  #  configuration {
  #    execute_command_configuration {
  #      logging = "OVERRIDE"
  #      log_configuration {
  #        cloud_watch_encryption_enabled = true
  #        cloud_watch_log_group_name     = aws_cloudwatch_log_group.ecs_logs.name
  #      }
  #    }
  #  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = module.default_tags.tags
}

resource "aws_ecs_capacity_provider" "ecs_ec2" {
  name = "ec2-capacity"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs.arn
    managed_termination_protection = "DISABLED"
    managed_scaling {
      maximum_scaling_step_size = 3
      minimum_scaling_step_size = 1
      instance_warmup_period    = 240
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }

  tags = module.default_tags.tags
}

resource "aws_ecs_cluster_capacity_providers" "ecs_ec2" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = [aws_ecs_capacity_provider.ecs_ec2.name]

  default_capacity_provider_strategy {
    base              = 0
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.ecs_ec2.name
  }
}

#resource "aws_cloudwatch_log_group" "ecs_logs" {
#  name = "ecs-logs-${local.naming_convention}"
#}