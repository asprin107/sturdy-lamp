# EKS IRSA for cluster-autoscaler
module "irsa_role" {
  source = "../irsa-role"

  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_provider_url
  suffix                = "cluster-autoscaler-${var.suffix}"

  k8s_namespace            = "kube-system"
  k8s_service_account_name = var.k8s_service_account_name
}

resource "aws_iam_role_policy_attachment" "irsa-att" {
  policy_arn = aws_iam_policy.irsa-cluster-autoscaler.arn
  role       = module.irsa_role.role.name
}

resource "aws_iam_policy" "irsa-cluster-autoscaler" {
  name   = "eks-irsa-cluster-autoscaler-${var.suffix}"
  policy = data.aws_iam_policy_document.irsa-cluster-autoscaler.json
}