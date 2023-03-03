data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["lamp"]
  }
}

data "aws_subnets" "instance_deployed" {
  filter {
    name   = "tag:Name"
    values = ["lamp-pub-sbn-*"]
  }
}