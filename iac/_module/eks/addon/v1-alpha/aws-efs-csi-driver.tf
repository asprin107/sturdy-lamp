resource "aws_eks_addon" "aws-efs-csi-driver" {
  count                       = var.aws-efs-csi-driver-enabled ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "aws-efs-csi-driver"
  addon_version               = var.aws-efs-csi-driver-addon_version
  resolve_conflicts_on_create = var.aws-efs-csi-driver-resolve_conflicts_on_create
  resolve_conflicts_on_update = var.aws-efs-csi-driver-resolve_conflicts_on_update
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