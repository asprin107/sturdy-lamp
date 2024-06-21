resource "aws_eks_addon" "aws-mountpoint-s3-csi-driver" {
  count                       = var.aws-mountpoint-s3-csi-driver-enabled ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "aws-mountpoint-s3-csi-driver"
  addon_version               = var.aws-mountpoint-s3-csi-driver-addon_version
  resolve_conflicts_on_create = var.aws-mountpoint-s3-csi-driver-resolve_conflicts_on_create
  resolve_conflicts_on_update = var.aws-mountpoint-s3-csi-driver-resolve_conflicts_on_update
  service_account_role_arn    = aws_iam_role.aws-mountpoint-s3-csi-driver[0].arn
  tags = merge(
    var.tags
  )
}

resource "aws_iam_role" "aws-mountpoint-s3-csi-driver" {
  count              = var.aws-mountpoint-s3-csi-driver-enabled ? 1 : 0
  name               = "${var.name}-AmazonEKS_S3_CSI_DriverRole"
  assume_role_policy = data.aws_iam_policy_document.aws-mountpoint-s3-csi-driver-trusted[0].json
  tags = merge(
    var.tags
  )
}
resource "aws_iam_policy" "aws-mountpoint-s3-csi-driver" {
  count  = var.aws-mountpoint-s3-csi-driver-enabled ? 1 : 0
  name   = "${var.name}-AmazonEKS_S3_CSI_DriverPolicy"
  policy = data.aws_iam_policy_document.aws-mountpoint-s3-csi-driver-policy[0].json
  tags = merge(
    var.tags
  )
}
resource "aws_iam_role_policy_attachment" "aws-mountpoint-s3-csi-driver" {
  count      = var.aws-mountpoint-s3-csi-driver-enabled ? 1 : 0
  role       = aws_iam_role.aws-mountpoint-s3-csi-driver[0].name
  policy_arn = aws_iam_policy.aws-mountpoint-s3-csi-driver[0].arn
}
data "aws_iam_policy_document" "aws-mountpoint-s3-csi-driver-trusted" {
  count = var.aws-mountpoint-s3-csi-driver-enabled ? 1 : 0
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
      test     = " StringLike"
      values   = ["system:serviceaccount:kube-system:s3-csi-*"]
      variable = "${replace(var.eks_oidc_issuer_url, "https://", "")}:sub"
    }
    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "${replace(var.eks_oidc_issuer_url, "https://", "")}:aud"
    }
  }
}
data "aws_iam_policy_document" "aws-mountpoint-s3-csi-driver-policy" {
  count = var.aws-mountpoint-s3-csi-driver-enabled ? 1 : 0
  statement {
    sid    = "MountpointFullBucketAccess"
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = var.aws-mountpoint-s3-csi-driver-target_s3
  }
  statement {
    sid    = "MountpointFullObjectAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:DeleteObject"
    ]
    resources = [for v in var.aws-mountpoint-s3-csi-driver-target_s3 : "${v}/*"]
  }
}


variable "aws-mountpoint-s3-csi-driver-enabled" {
  description = ""
  type        = bool
  default     = false
}
variable "aws-mountpoint-s3-csi-driver-addon_version" {
  description = ""
  type        = string
  default     = "v1.5.1-eksbuild.1"
}
variable "aws-mountpoint-s3-csi-driver-resolve_conflicts_on_create" {
  description = ""
  type        = string
  default     = "OVERWRITE" // NONE | OVERWRITE
}
variable "aws-mountpoint-s3-csi-driver-resolve_conflicts_on_update" {
  description = ""
  type        = string
  default     = "NONE" // NONE | OVERWRITE | PRESERVE
}
variable "aws-mountpoint-s3-csi-driver-target_s3" {
  description = "S3 arn list allowed mount."
  type        = set(string)
  default     = []
}