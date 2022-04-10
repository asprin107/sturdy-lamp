# TODO Create CodeDeploy

resource "aws_codedeploy_app" "nginx" {
  name             = "${var.project_name}-codedeploy"
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_config" "nginx" {
  deployment_config_name = "${var.project_name}-canary-5p5m"
  compute_platform       = "ECS"
  traffic_routing_config {
    type = "TimeBasedCanary"
    time_based_canary {
      interval   = 5
      percentage = 5
    }
  }
}