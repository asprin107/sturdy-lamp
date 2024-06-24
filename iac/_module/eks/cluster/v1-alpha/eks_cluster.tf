resource "aws_eks_cluster" "eks" {
  name     = var.name
  role_arn = aws_iam_role.eks.arn
  version  = var.eks_version

  vpc_config {
    subnet_ids              = var.eks_subnet_ids
    security_group_ids      = var.eks_security_group_ids
    endpoint_public_access  = true
    endpoint_private_access = true
    public_access_cidrs     = concat(var.eks_public_access_cidrs, ["${chomp(data.http.current_ip.response_body)}/32"])
  }

  kubernetes_network_config {
    service_ipv4_cidr = "172.16.0.0/12"
    ip_family         = "ipv4"
  }

  tags = local.tags
}


resource "aws_eks_node_group" "default" {
  node_group_name = "${var.name}-default"
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)

  cluster_name  = aws_eks_cluster.eks.name
  node_role_arn = aws_iam_role.eks_node.arn
  subnet_ids    = var.eks_subnet_ids

  capacity_type  = var.eks_nodegroup_capacity_type
  ami_type       = var.eks_nodegroup_ami_type
  instance_types = var.eks_nodegroup_instance_types # Default
  disk_size      = var.eks_nodegroup_disk_size
  labels = {
    type = "eks-default"
  }

  scaling_config {
    desired_size = var.eks_nodegroup_desired_size
    max_size     = var.eks_nodegroup_max_size
    min_size     = var.eks_nodegroup_min_size
  }

  update_config {
    max_unavailable = var.eks_nodegroup_max_unavailable
    #    max_unavailable_percentage = 50
  }

  tags = merge(
    local.tags,
    {
      EKSType    = "NodeGroup"
      EKSCluster = aws_eks_cluster.eks.arn
    }
  )

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}

data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.eks.version}/amazon-linux-2/recommended/release_version"
}

data "http" "current_ip" {
  url = "https://ipinfo.io/ip"
}