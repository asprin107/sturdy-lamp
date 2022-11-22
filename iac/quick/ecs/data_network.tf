data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["lamp"]
  }
}

data "aws_subnets" "pub_subnets" {
  filter {
    name   = "tag:Name"
    values = ["lamp-pub-sbn-*"]
  }
}

data "aws_security_groups" "ecs" {
  filter {
    name   = "tag:Name"
    values = ["sg-ecs-service"]
  }
}