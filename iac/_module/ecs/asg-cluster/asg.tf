resource "aws_autoscaling_group" "ecs_node_group" {
  name     = var.ecs_asg.name
  max_size = var.ecs_asg.max_size
  min_size = var.ecs_asg.min_size

  capacity_rebalance = false

  default_cooldown        = var.ecs_asg.default_cooldown
  default_instance_warmup = var.ecs_asg.default_instance_warmup

  health_check_grace_period = var.ecs_asg.health_check_grace_period
  health_check_type         = "EC2" # EC2 / ELB
  force_delete              = false

  vpc_zone_identifier = data.aws_subnets.ecs_subnets.ids

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.ecs-node.id
      }
    }
  }

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = var.ecs_asg.name
  }
  tag {
    key                 = "Account"
    propagate_at_launch = true
    value               = var.tags.Account
  }
  tag {
    key                 = "Environment"
    propagate_at_launch = true
    value               = var.tags.Environment
  }
  tag {
    key                 = "Project"
    propagate_at_launch = true
    value               = var.tags.Project
  }
}