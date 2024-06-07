resource "aws_eks_addon" "adot" {
  count                       = var.adot-enabled ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "adot"
  addon_version               = var.adot-addon_version
  resolve_conflicts_on_create = var.adot-resolve_conflicts_on_create
  resolve_conflicts_on_update = var.adot-resolve_conflicts_on_update
}


variable "adot-enabled" {
  description = ""
  type        = bool
  default     = false
}
variable "adot-addon_version" {
  description = ""
  type        = string
  default     = "v0.94.1-eksbuild.1"
}
variable "adot-resolve_conflicts_on_create" {
  description = ""
  type        = string
  default     = "OVERWRITE" // NONE | OVERWRITE
}
variable "adot-resolve_conflicts_on_update" {
  description = ""
  type        = string
  default     = "NONE" // NONE | OVERWRITE | PRESERVE
}