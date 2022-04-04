locals {
  alb_name = "${var.project_name}-alb"
}

resource "aws_alb_target_group" "alb_http_service_tg" {
  vpc_id      = var.main_vpc_id
  name        = "${local.alb_name}-service"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
}
resource "aws_alb_target_group" "alb_http_test_tg" {
  vpc_id      = var.main_vpc_id
  name        = "${local.alb_name}-test"
  port        = 81
  protocol    = "HTTP"
  target_type = "ip"
}

resource "aws_lb" "nginx" {
  depends_on = [aws_s3_bucket_policy.alb_access]
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
      Name = local.alb_name
    }
  )
}

resource "aws_lb_listener" "nginx_http" {
  load_balancer_arn = aws_lb.nginx.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.alb_http_service_tg.arn
  }
  tags = merge(
    var.tags,
    {
      Name = "${local.alb_name}-service-listener"
    }
  )
}
resource "aws_lb_listener" "nginx_http_test" {
  load_balancer_arn = aws_lb.nginx.arn
  port = 81
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.alb_http_test_tg.arn
  }
  tags = merge(
    var.tags,
    {
      Name = "${local.alb_name}-test-listener"
    }
  )
}