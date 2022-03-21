# target group
# TODO Security group (ALB)
# TODO ALb nginx
# TODO ALB Listener
# TODO ALB Listener rule
# TODO ALB Listener rule assiciation
# TODO ECS Cluster
# TODO ECS Task
# TODO ECS Service

resource "aws_alb_target_group" "alb_http_service_tg" {
  vpc_id      = var.main_vpc_id
  name        = "${var.project_name}-service"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
}
resource "aws_alb_target_group" "alb_http_test_tg" {
  vpc_id      = var.main_vpc_id
  name        = "${var.project_name}-test"
  port        = 81
  protocol    = "HTTP"
  target_type = "ip"
}
