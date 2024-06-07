resource "aws_eks_addon" "aws-ebs-csi-driver" {
  count                       = var.aws-ebs-csi-driver-enabled ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = var.aws-ebs-csi-driver-addon_version
  resolve_conflicts_on_create = var.aws-ebs-csi-driver-resolve_conflicts_on_create
  resolve_conflicts_on_update = var.aws-ebs-csi-driver-resolve_conflicts_on_update
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