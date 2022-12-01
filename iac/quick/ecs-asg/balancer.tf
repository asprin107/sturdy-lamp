resource "aws_alb_target_group" "alb_http_tg_1" {
  vpc_id      = data.aws_vpc.main.id
  name        = "${local.alb_name}-tg-1"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
    timeout             = 5
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    matcher             = "200"
  }
}
resource "aws_alb_target_group" "alb_http_tg_2" {
  vpc_id      = data.aws_vpc.main.id
  name        = "${local.alb_name}-tg-2"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
    timeout             = 5
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    matcher             = "200"
  }
}

resource "aws_lb" "ecs" {
  load_balancer_type         = "application"
  internal                   = false
  name                       = local.alb_name
  security_groups            = data.aws_security_groups.ecs-lb.ids
  drop_invalid_header_fields = false
  access_logs {
    bucket  = data.terraform_remote_state.shared-resource.outputs.s3_access_logs
    prefix  = local.alb_name
    enabled = true
  }
  subnets                    = data.aws_subnets.pub_subnets.ids
  idle_timeout               = 60
  enable_deletion_protection = false
  enable_http2               = true
  ip_address_type            = "ipv4"      # Available value is "ipv4", "dualstack". dualstack means use ipv4 and ipv6
  desync_mitigation_mode     = "defensive" # HTTP desync attack. https://docs.aws.amazon.com/elasticloadbalancing/latest/application/application-load-balancers.html#desync-mitigation-mode

  tags = merge(
    {
      Name = local.alb_name
    }
  )
}

resource "aws_lb_listener" "http_service" {
  load_balancer_arn = aws_lb.ecs.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_http_tg_1.arn
  }
  tags = merge(
    {
      Name = "${local.alb_name}-service-listener"
    }
  )

  lifecycle {
    ignore_changes = [
      default_action # Target changed by CodeDeploy
    ]
  }
}
resource "aws_lb_listener" "http_test" {
  load_balancer_arn = aws_lb.ecs.arn
  port              = 81
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_http_tg_2.arn
  }
  tags = merge(
    {
      Name = "${local.alb_name}-test-listener"
    }
  )

  lifecycle {
    ignore_changes = [
      default_action # Target changed by CodeDeploy
    ]
  }
}