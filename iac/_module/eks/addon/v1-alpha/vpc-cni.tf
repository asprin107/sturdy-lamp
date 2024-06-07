resource "aws_eks_addon" "vpc-cni" {
  count                       = var.vpc-cni-enabled ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "vpc-cni"
  addon_version               = var.vpc-cni-addon_version
  resolve_conflicts_on_create = var.vpc-cni-resolve_conflicts_on_create
  resolve_conflicts_on_update = var.vpc-cni-resolve_conflicts_on_update
  service_account_role_arn    = aws_iam_role.vpc-cni[0].arn
  tags = merge(
    var.tags
  )
}

resource "aws_iam_role" "vpc-cni" {
  count              = var.vpc-cni-enabled ? 1 : 0
  name               = "${var.name}-AmazonEKSVPCCNIRole"
  assume_role_policy = data.aws_iam_policy_document.vpc-cni-trusted[0].json
  tags = merge(
    var.tags
  )
}
resource "aws_iam_role_policy_attachment" "vpc-cni" {
  count      = var.vpc-cni-enabled ? 1 : 0
  role       = aws_iam_role.vpc-cni[0].name
  policy_arn = data.aws_iam_policy.vpc-cni-ipv4[0].arn
}
data "aws_iam_policy" "vpc-cni-ipv4" {
  count = var.vpc-cni-enabled ? 1 : 0
  name  = "AmazonEKS_CNI_Policy"
}
data "aws_iam_policy_document" "vpc-cni-trusted" {
  count = var.vpc-cni-enabled ? 1 : 0
  statement {
    principals {
      type = "Federated"
      identifiers = [
        var.eks_oidc_provider_arn
      ]
    }
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      values   = ["system:serviceaccount:kube-system:aws-node"]
      variable = "${replace(var.eks_oidc_issuer_url, "https://", "")}:sub"
    }
    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "${replace(var.eks_oidc_issuer_url, "https://", "")}:aud"
    }
  }
}


variable "vpc-cni-enabled" {
  description = ""
  type        = bool
  default     = true
}
variable "vpc-cni-addon_version" {
  description = ""
  type        = string
  default     = "v1.18.2-eksbuild.1"
}
variable "vpc-cni-resolve_conflicts_on_create" {
  description = ""
  type        = string
  default     = "OVERWRITE" // NONE | OVERWRITE
}
variable "vpc-cni-resolve_conflicts_on_update" {
  description = ""
  type        = string
  default     = "NONE" // NONE | OVERWRITE | PRESERVE
}