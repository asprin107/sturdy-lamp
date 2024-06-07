resource "aws_eks_addon" "vpc-cni" {
  count                       = var.vpc-cni-enabled ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "vpc-cni"
  addon_version               = var.vpc-cni-addon_version
  resolve_conflicts_on_create = var.vpc-cni-resolve_conflicts_on_create
  resolve_conflicts_on_update = var.vpc-cni-resolve_conflicts_on_update
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