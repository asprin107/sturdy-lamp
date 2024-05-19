module "external_secrets" {
  source = "../../_module/eks/addon/external-secrets"

  iam = {
    role_name   = "EKSExternalSecretsIRSA"
    policy_name = "EKSExternalSecretsIRSA"
  }
  eks = {
    oidc_provider_arn = module.eks_cluster.eks.oidc_provider_arn
    oidc_issuer_url   = module.eks_cluster.eks.oidc_issuer_url
  }
  serviceaccount = {
    namespace = "external-secrets"
    name      = "external-secrets"
  }

  essential_tags = module.default_tags.tags
}

module "aws_ebs_csi_driver" {
  source = "../../_module/eks/addon/aws_ebs_csi_driver"

  eks = {
    cluster_name      = module.eks_cluster.eks.cluster_name
    oidc_provider_arn = module.eks_cluster.eks.oidc_provider_arn
    oidc_issuer_url   = module.eks_cluster.eks.oidc_issuer_url
  }

  essential_tags = module.default_tags.tags
}