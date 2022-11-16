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

  tags = merge(
    module.default_tags.tags
  )
}


resource "aws_eks_node_group" "default" {
  node_group_name = "${var.project}-${var.service}-${var.env}-default"
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)

  cluster_name  = aws_eks_cluster.eks.name
  node_role_arn = aws_iam_role.eks_node.arn
  subnet_ids    = data.aws_subnets.pub_subnets.ids

  capacity_type  = "ON_DEMAND"
  ami_type       = "AL2_x86_64"
  instance_types = ["t3.medium"] # Default
  disk_size      = 20
  labels = {
    type = "ec2-default"
  }

  scaling_config {
    desired_size = 1
    max_size     = 4
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
    #    max_unavailable_percentage = 50
  }

  tags = merge(
    module.default_tags.tags,
    {
      EKSType    = "NodeGroup"
      EKSCluster = aws_eks_cluster.eks.arn
    }
  )

  #  lifecycle {
  #    ignore_changes = [scaling_config[0].desired_size]
  #  }
}

data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.eks.version}/amazon-linux-2/recommended/release_version"
}