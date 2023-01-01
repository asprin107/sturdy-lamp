resource "aws_ecs_cluster" "main" {
  name = var.ecs.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.tags
}

resource "aws_ecs_capacity_provider" "ecs_ec2" {
  name = "ec2-capacity"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_node_group.arn
    managed_termination_protection = "DISABLED"
    managed_scaling {
      maximum_scaling_step_size = var.ecs_asg.max_size
      minimum_scaling_step_size = var.ecs_asg.min_size
      instance_warmup_period    = var.ecs.instance_warmup_period
      status                    = "ENABLED"
      target_capacity           = var.ecs.target_capacity
    }
  }

  tags = var.tags
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