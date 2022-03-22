# target group
# ALb nginx
# TODO ALB Listener
# TODO ALB Listener rule
# TODO ALB Listener rule assiciation
# TODO ECS Cluster
# TODO ECS Task
# TODO ECS Service

locals {
  alb_name = "${var.project_name}-alb"
}

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

resource "aws_lb" "nginx" {
  load_balancer_type         = "application"
  internal                   = false
  name                       = local.alb_name
  security_groups            = [aws_security_group.alb_nginx_sg.id]
  drop_invalid_header_fields = false
  access_logs {
    bucket  = aws_s3_bucket.alb_access_log.bucket
    prefix  = local.alb_name
    enabled = true
  }
  subnets                    = var.alb_subnet_ids
  idle_timeout               = 60
  enable_deletion_protection = true
  enable_http2               = true
  ip_address_type            = "ipv4"      # Available value is "ipv4", "dualstack". dualstack means use ipv4 and ipv6
  desync_mitigation_mode     = "defensive" # HTTP desync attack. https://docs.aws.amazon.com/elasticloadbalancing/latest/application/application-load-balancers.html#desync-mitigation-mode

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-vpc"
    }
  )
}