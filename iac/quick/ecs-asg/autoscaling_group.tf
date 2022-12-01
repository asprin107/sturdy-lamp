resource "aws_autoscaling_group" "ecs" {
  name     = "asg-${local.naming_convention}"
  min_size = 0
  max_size = 2

  capacity_rebalance = false

  default_cooldown        = 300
  default_instance_warmup = 180

  #  launch_template {
  #    id = var.launch_template_id
  #  }

  health_check_grace_period = 300
  health_check_type         = "EC2" # EC2 / ELB
  protect_from_scale_in     = false
  force_delete              = false

  vpc_zone_identifier = data.aws_subnets.pub_subnets.ids

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
    value               = "asg-ec2-${local.naming_convention}"
  }
  tag {
    key                 = "Account"
    propagate_at_launch = true
    value               = var.aws_account
  }
  tag {
    key                 = "Environment"
    propagate_at_launch = true
    value               = var.env
  }
  tag {
    key                 = "Project"
    propagate_at_launch = true
    value               = var.project
  }
  tag {
    key                 = "AutoScalingGroup"
    propagate_at_launch = true
    value               = "asg-${local.naming_convention}"
  }
}

data "aws_ssm_parameter" "ami-ecs-node-arm" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/arm64/recommended/image_id"
}

resource "aws_launch_template" "ecs-node" {
  description = "launch template for mafia backend service."

  name          = "lt-ecs-${local.naming_convention}"
  image_id      = data.aws_ssm_parameter.ami-ecs-node-arm.value # ECS ARM : "ami-09f43ca191c371485" (at 2022.12.01)
  instance_type = "m6g.large"
  key_name      = "ec2-test"

  update_default_version = false

  iam_instance_profile {
    arn = aws_iam_instance_profile.instance_profile.arn
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = data.aws_security_groups.ecs.ids
  }

  instance_initiated_shutdown_behavior = "terminate"
  #  vpc_security_group_ids               = [aws_security_group.bnd-sg.id]

  user_data = base64encode("#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config;echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config;")

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      encrypted             = true
      volume_size           = 100
      volume_type           = "gp2"
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
      Launch_template = "lt-ecs-${local.naming_convention}"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      Launch_template = "lt-ecs-${local.naming_convention}"
    }
  }

  tags = module.default_tags.tags
}