resource "helm_release" "argocd" {
  count            = var.argocd-enabled ? 1 : 0
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  version = var.argocd-version

  values = var.argocd-values

  dynamic "set" {
    for_each = local.check_service_type
    content {
      name  = set.key
      value = set.value
    }
  }
}

variable "argocd-enabled" {
  type    = bool
  default = true
}

variable "argocd-version" {
  type    = string
  default = "6.7.18"
}

variable "argocd-type" {
  type    = string // simple / custom
  default = "simple"
}

variable "argocd-values" {
  type    = list(string)
  default = []
}

locals {
  check_service_type = var.argocd-enabled && var.argocd-type == "simple" ? {
    "server.service.type" = "LoadBalancer"
  } : {}
}