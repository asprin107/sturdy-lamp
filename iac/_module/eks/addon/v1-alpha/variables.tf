variable "name" {
  description = "Name to be used for the created resources."
  type        = string
}

variable "eks_cluster_name" {
  description = "EKS cluster name that addons will be deployed."
  type        = string
}

variable "eks_oidc_issuer_url" {
  description = "EKS OIDC issuer url."
  type        = string
}

variable "eks_oidc_provider_arn" {
  description = "EKS OIDC Provider arn."
  type        = string
}

variable "tags" {
  description = "default tags."
  type        = any
  default     = {}
}