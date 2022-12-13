module "eks-cluster" {
  source = "../../_module/eks/cluster"

  eks = {
    subnet_ids         = data.aws_subnets.eks_cluster.ids
    security_group_ids = data.aws_security_groups.eks_cluster.ids

    node_group = {
      capacity_type   = "ON_DEMAND"
      ami_type        = "AL2_x86_64"
      instance_types  = ["t3.medium"]
      disk_size       = 40
      desired_size    = 1
      max_size        = 4
      min_size        = 1
      max_unavailable = 1
    }
  }

  essential_tags = module.default_tags.tags
}

data "aws_security_groups" "eks_cluster" {
  filter {
    name   = "tag:Name"
    values = ["sg-eks-node"]
  }
}

data "aws_subnets" "eks_cluster" {
  filter {
    name   = "tag:Name"
    values = ["lamp-pub-sbn-*"]
  }
}