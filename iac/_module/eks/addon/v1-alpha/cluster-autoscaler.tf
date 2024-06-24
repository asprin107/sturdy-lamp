module "irsa-cluster_autoscaler" {
  count  = var.cluster_autoscaler-enabled ? 1 : 0
  source = "../../../iam/irsa/cluster-autoscaler"

  eks_name              = var.eks_cluster_name
  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_issuer_url
  suffix                = var.name
}

variable "cluster_autoscaler-enabled" {
  type    = bool
  default = true
}