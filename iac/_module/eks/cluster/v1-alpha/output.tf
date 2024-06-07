output "eks_cluster_values" {
  description = ""
  value       = aws_eks_cluster.eks
}

output "eks" {
  description = "EKS oidc info."
  value = {
    cluster_name      = aws_eks_cluster.eks.name
    oidc_issuer_url   = try(aws_eks_cluster.eks.identity[0].oidc[0].issuer, null)
    oidc_provider_arn = try(aws_iam_openid_connect_provider.eks_oidc.arn, null)
  }
}