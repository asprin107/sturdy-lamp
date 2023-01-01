resource "aws_launch_template" "ecs-node" {
  description = "launch template for ecs node group."

  name          = var.ecs_asg.launch_template.name
  image_id      = local.asg_instance_arch[var.ecs_asg.launch_template.arch]
  instance_type = var.ecs_asg.launch_template.instance_type
  key_name      = var.ecs_asg.launch_template.key_name

  update_default_version = false

  iam_instance_profile {
    arn = aws_iam_instance_profile.instance_profile.arn
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.asg_node_group.id]
  }

  instance_initiated_shutdown_behavior = "terminate"

  user_data = base64encode("#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config;echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config;")

  block_device_mappings {
    device_name = var.ecs_asg.launch_template.device_name
    ebs {
      delete_on_termination = true
      encrypted             = true
      volume_size           = var.ecs_asg.launch_template.volume_size
      volume_type           = var.ecs_asg.launch_template.volume_type
    }
  }

  maintenance_options {
    auto_recovery = "disabled"
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Launch_template = var.ecs_asg.launch_template.name
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      Launch_template = var.ecs_asg.launch_template.name
    }
  }

  tags = var.tags
}