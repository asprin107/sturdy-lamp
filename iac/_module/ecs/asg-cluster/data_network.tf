data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = var.filter_vpc_name
  }
}

data "aws_subnets" "ecs_subnets" {
  filter {
    name   = "tag:Name"
    values = var.filter_sbn_name
  }
}