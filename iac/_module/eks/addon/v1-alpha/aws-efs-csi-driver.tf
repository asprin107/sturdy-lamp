resource "aws_eks_addon" "aws-efs-csi-driver" {
  count                       = var.aws-efs-csi-driver-enabled ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "aws-efs-csi-driver"
  addon_version               = var.aws-efs-csi-driver-addon_version
  resolve_conflicts_on_create = var.aws-efs-csi-driver-resolve_conflicts_on_create
  resolve_conflicts_on_update = var.aws-efs-csi-driver-resolve_conflicts_on_update
  service_account_role_arn    = aws_iam_role.aws-efs-csi-driver[0].arn
  tags = merge(
    var.tags
  )
}

resource "aws_iam_role" "aws-efs-csi-driver" {
  count              = var.aws-efs-csi-driver-enabled ? 1 : 0
  name               = "${var.name}-AmazonEKS_EFS_CSI_DriverRole"
  assume_role_policy = data.aws_iam_policy_document.aws-efs-csi-driver-trusted[0].json
  tags = merge(
    var.tags
  )
}
resource "aws_iam_role_policy_attachment" "aws-efs-csi-driver" {
  count      = var.aws-efs-csi-driver-enabled ? 1 : 0
  role       = aws_iam_role.aws-efs-csi-driver[0].name
  policy_arn = data.aws_iam_policy.aws-efs-csi-driver[0].arn
}
data "aws_iam_policy" "aws-efs-csi-driver" {
  count = var.aws-efs-csi-driver-enabled ? 1 : 0
  name  = "AmazonEFSCSIDriverPolicy"
}
data "aws_iam_policy_document" "aws-efs-csi-driver-trusted" {
  count = var.aws-efs-csi-driver-enabled ? 1 : 0
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
      values   = ["system:serviceaccount:system:serviceaccount:kube-system:efs-csi-*"]
      variable = "${replace(var.eks_oidc_issuer_url, "https://", "")}:sub"
    }
    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "${replace(var.eks_oidc_issuer_url, "https://", "")}:aud"
    }
  }
}


variable "aws-efs-csi-driver-enabled" {
  description = ""
  type        = bool
  default     = false
}
variable "aws-efs-csi-driver-addon_version" {
  description = ""
  type        = string
  default     = "v2.0.3-eksbuild.1"
}
variable "aws-efs-csi-driver-resolve_conflicts_on_create" {
  description = ""
  type        = string
  default     = "OVERWRITE" // NONE | OVERWRITE
}
variable "aws-efs-csi-driver-resolve_conflicts_on_update" {
  description = ""
  type        = string
  default     = "NONE" // NONE | OVERWRITE | PRESERVE
}