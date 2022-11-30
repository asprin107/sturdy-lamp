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

#resource "aws_ecs_cluster_capacity_providers" "ecs_infra" {
#  cluster_name = aws_ecs_cluster.main.name
#
#  capacity_providers = ["FARGATE"]
#
#  default_capacity_provider_strategy {
#    base              = 0
#    weight            = 100
#    capacity_provider = "FARGATE"
#  }
#}

#resource "aws_cloudwatch_log_group" "ecs_logs" {
#  name = "ecs-logs-${local.naming_convention}"
#}