resource "aws_eks_cluster" "eks" {
  name     = "${var.project}-${var.service}-${var.env}"
  role_arn = aws_iam_role.eks.arn
  version  = "1.23"

  vpc_config {
    subnet_ids         = data.aws_subnets.pub_subnets.ids
    security_group_ids = data.aws_security_groups.eks_cluster.ids
  }

  kubernetes_network_config {
    service_ipv4_cidr = "172.16.0.0/12"
    ip_family         = "ipv4"
  }

  tags = module.default_tags.tags
}