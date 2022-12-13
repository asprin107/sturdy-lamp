# EKS IRSA for cluster-autoscaler
resource "aws_iam_policy" "irsa-cluster-autoscaler" {
  name   = "${var.prefix}-eks-irsa-cluster-autoscaler"
  policy = data.aws_iam_policy_document.irsa-cluster-autoscaler.json
}