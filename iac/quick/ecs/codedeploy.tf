#resource "aws_codedeploy_app" "haegol" {
#  name             = "${local.naming_convention}-codedeploy"
#  compute_platform = "ECS"
#}
#
#resource "aws_codedeploy_deployment_group" "haegol" {
#  app_name               = aws_codedeploy_app.haegol.name
#  deployment_group_name  = "${local.naming_convention}-deployment-group"
#  service_role_arn       = aws_iam_role.codedeploy-ecs.arn
#  deployment_config_name = aws_codedeploy_deployment_config.deploy_app_config.id
#
#  ecs_service {
#    cluster_name = aws_ecs_cluster.main.name
#    service_name = aws_ecs_service.haegol.name
#  }
#}
#
#resource "aws_codedeploy_deployment_config" "deploy_app_config" {
#  deployment_config_name = "${local.naming_convention}-all-at-once"
#  compute_platform       = "ECS"
#  traffic_routing_config {
#    type = "AllAtOnce"
##    type = "TimeBasedCanary"
##    time_based_canary {
##      interval   = 5
##      percentage = 100
##    }
#  }
#}