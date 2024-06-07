module "eks" {
  source = "../../_module/eks/cluster/v1-alpha"

  name           = module.naming.name
  eks_subnet_ids = module.network.public_subnet_ids
}