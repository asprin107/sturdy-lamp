resource "aws_eks_cluster" "eks" {
  name     = local.naming
  role_arn = aws_iam_role.eks.arn
  version  = "1.24"

  vpc_config {
    subnet_ids         = var.eks.subnet_ids
    security_group_ids = var.eks.security_group_ids
  }

  kubernetes_network_config {
    service_ipv4_cidr = "172.16.0.0/12"
    ip_family         = "ipv4"
  }

  tags = local.tags
}


resource "aws_eks_node_group" "default" {
  node_group_name = "${local.naming}-default"
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)

  cluster_name  = aws_eks_cluster.eks.name
  node_role_arn = aws_iam_role.eks_node.arn
  subnet_ids    = var.eks.subnet_ids

  capacity_type  = var.eks.node_group.capacity_type
  ami_type       = var.eks.node_group.ami_type
  instance_types = var.eks.node_group.instance_types # Default
  disk_size      = var.eks.node_group.disk_size
  labels = {
    type = "eks-default"
  }

  scaling_config {
    desired_size = var.eks.node_group.desired_size
    max_size     = var.eks.node_group.max_size
    min_size     = var.eks.node_group.min_size
  }

  update_config {
    max_unavailable = var.eks.node_group.max_unavailable
    #    max_unavailable_percentage = 50
  }

  tags = merge(
    local.tags,
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