module "eks" {
  source = "../../_module/eks/cluster/v1-alpha"

  name           = module.naming.name
  eks_subnet_ids = module.network.private_subnet_ids
}

module "addon" {
  source = "../../_module/eks/addon/v1-alpha"

  name                  = module.naming.name
  vpc_id                = module.network.main_vpc_id
  eks_cluster_name      = module.eks.eks_info.cluster_name
  eks_oidc_issuer_url   = module.eks.eks_info.oidc_issuer_url
  eks_oidc_provider_arn = module.eks.eks_info.oidc_provider_arn

  argocd-enabled                       = true
  argocd-type                          = "custom"
  aws_load_balancer_controller-enabled = true
  cluster_autoscaler-enabled           = true
}