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

data "aws_security_groups" "eks_cluster" {
  filter {
    name   = "tag:Name"
    values = ["sg-eks-cluster"]
  }
}

data "aws_security_groups" "eks_node" {
  filter {
    name   = "tag:Name"
    values = ["sg-eks-node"]
  }
}