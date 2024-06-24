resource "helm_release" "applications" {
  count            = var.apps-enabled ? 1 : 0
  repository       = "https://asprin107@github.com/asprin107/kubernetes-applications/tree/main/apps"
  chart            = "apps"
  name             = "applications"
  namespace        = "argocd"
  create_namespace = true

  version = var.apps-version

  values = var.apps-values
}

variable "apps-enabled" {
  type    = bool
  default = true
}

variable "apps-version" {
  type    = string
  default = "main"
}

variable "apps-values" {
  type    = list(string)
  default = []
}