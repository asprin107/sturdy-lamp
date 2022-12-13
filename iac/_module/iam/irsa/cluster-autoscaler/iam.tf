# EKS IRSA for cluster-autoscaler
module "role" {
  source = "../irsa-role"

  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_provider_url
  suffix                = var.suffix
}

resource "aws_iam_policy" "irsa-cluster-autoscaler" {
  name   = "eks-irsa-cluster-autoscaler-${var.suffix}"
  policy = data.aws_iam_policy_document.irsa-cluster-autoscaler.json
}