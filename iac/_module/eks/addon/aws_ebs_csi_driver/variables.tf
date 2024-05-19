variable "essential_tags" {
  description = "Essential tags for module."
  type = object({
    Project     = string
    Service     = string
    Management  = string
    Account     = string
    Environment = string
  })
}

variable "custom_tags" {
  description = "Custom tags for module."
  type        = map(any)
  default     = {}
}

variable "addon_version" {
  description = "The version of Add on."
  type        = string
  default     = "v1.30.0-eksbuild.1"
}

variable "eks" {
  description = "Eks cluster OIDC info"
  type = object({
    cluster_name      = string
    oidc_provider_arn = string
    oidc_issuer_url   = string
  })
}

variable "serviceaccount" {
  description = "Service Account info"
  type = object({
    namespace = string
    name      = string
  })
  # Default values reference: https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html
  default = {
    namespace = "kube-system"
    name      = "ebs-csi-controller-sa"
  }
}