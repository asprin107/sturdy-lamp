resource "aws_codedeploy_app" "haegol" {
  name             = "${local.naming_convention}-codedeploy"
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_group" "haegol" {
  app_name               = aws_codedeploy_app.haegol.name
  deployment_group_name  = "${local.naming_convention}-deployment-group"
  service_role_arn       = aws_iam_role.codedeploy-ecs.arn
  deployment_config_name = aws_codedeploy_deployment_config.deploy_app_config.id

  load_balancer_info {
    target_group_pair_info {
      target_group {
        name = aws_alb_target_group.alb_http_tg_1.name
      }
      target_group {
        name = aws_alb_target_group.alb_http_tg_2.name
      }
      prod_traffic_route {
        listener_arns = [aws_lb_listener.http_service.arn]
      }
      test_traffic_route {
        listener_arns = [aws_lb_listener.http_test.arn]
      }
    }
  }

  blue_green_deployment_config {
    deployment_ready_option {
      wait_time_in_minutes = 30
      action_on_timeout    = "STOP_DEPLOYMENT" # CONTINUE_DEPLOYMENT
    }
    #    green_fleet_provisioning_option {
    #      action = "DISCOVER_EXISTING" # COPY_AUTO_SCALING_GROUP
    #    }
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE" # KEEP_ALIVE
      termination_wait_time_in_minutes = 120
    }
  }

  deployment_style {
    deployment_type   = "BLUE_GREEN"           # IN_PLACE
    deployment_option = "WITH_TRAFFIC_CONTROL" # WITHOUT_TRAFFIC_CONTROL
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.main.name
    service_name = aws_ecs_service.haegol.name
  }
}

resource "aws_codedeploy_deployment_config" "deploy_app_config" {
  deployment_config_name = "${local.naming_convention}-all-at-once"
  compute_platform       = "ECS"
  traffic_routing_config {
    type = "AllAtOnce"
    #    type = "TimeBasedCanary"
    #    time_based_canary {
    #      interval   = 5
    #      percentage = 100
    #    }
  }
}