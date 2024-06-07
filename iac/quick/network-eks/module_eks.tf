module "eks" {
  source = "../../_module/eks/cluster/v1-alpha"

  name           = module.naming.name
  eks_subnet_ids = module.network.public_subnet_ids
}

module "addon" {
  source           = "../../_module/eks/addon/v1-alpha"
  eks_cluster_name = module.eks.eks_info.cluster_name
}