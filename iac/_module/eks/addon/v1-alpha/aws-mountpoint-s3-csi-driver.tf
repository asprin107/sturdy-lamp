resource "aws_eks_addon" "aws-mountpoint-s3-csi-driver" {
  count                       = var.aws-mountpoint-s3-csi-driver-enabled ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "aws-mountpoint-s3-csi-driver"
  addon_version               = var.aws-mountpoint-s3-csi-driver-addon_version
  resolve_conflicts_on_create = var.aws-mountpoint-s3-csi-driver-resolve_conflicts_on_create
  resolve_conflicts_on_update = var.aws-mountpoint-s3-csi-driver-resolve_conflicts_on_update
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