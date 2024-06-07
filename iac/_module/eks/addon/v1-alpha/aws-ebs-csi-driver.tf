resource "aws_eks_addon" "aws-ebs-csi-driver" {
  count                       = var.aws-ebs-csi-driver-enabled ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = var.aws-ebs-csi-driver-addon_version
  resolve_conflicts_on_create = var.aws-ebs-csi-driver-resolve_conflicts_on_create
  resolve_conflicts_on_update = var.aws-ebs-csi-driver-resolve_conflicts_on_update
  service_account_role_arn    = aws_iam_role.aws-ebs-csi-driver[0].arn
  tags = merge(
    var.tags
  )
}

resource "aws_iam_role" "aws-ebs-csi-driver" {
  count              = var.aws-ebs-csi-driver-enabled ? 1 : 0
  name               = "${var.name}-AmazonEKS_EBS_CSI_DriverRole"
  assume_role_policy = data.aws_iam_policy_document.aws-ebs-csi-driver-trusted[0].json
  tags = merge(
    var.tags
  )
}
resource "aws_iam_role_policy_attachment" "aws-ebs-csi-driver" {
  count      = var.aws-ebs-csi-driver-enabled ? 1 : 0
  role       = aws_iam_role.aws-ebs-csi-driver[0].name
  policy_arn = data.aws_iam_policy.aws-ebs-csi-driver[0].arn
}
data "aws_iam_policy" "aws-ebs-csi-driver" {
  count = var.aws-ebs-csi-driver-enabled ? 1 : 0
  name  = "AmazonEBSCSIDriverPolicy"
}
data "aws_iam_policy_document" "aws-ebs-csi-driver-trusted" {
  count = var.aws-ebs-csi-driver-enabled ? 1 : 0
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
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
      variable = "${replace(var.eks_oidc_issuer_url, "https://", "")}:sub"
    }
    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "${replace(var.eks_oidc_issuer_url, "https://", "")}:aud"
    }
  }
}


variable "aws-ebs-csi-driver-enabled" {
  description = ""
  type        = bool
  default     = true
}
variable "aws-ebs-csi-driver-addon_version" {
  description = ""
  type        = string
  default     = "v1.31.0-eksbuild.1"
}
variable "aws-ebs-csi-driver-resolve_conflicts_on_create" {
  description = ""
  type        = string
  default     = "OVERWRITE" // NONE | OVERWRITE
}
variable "aws-ebs-csi-driver-resolve_conflicts_on_update" {
  description = ""
  type        = string
  default     = "NONE" // NONE | OVERWRITE | PRESERVE
}