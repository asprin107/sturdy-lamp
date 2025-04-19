resource "argocd_application" "applications" {
  count = var.enabled_default_apps ? 1 : 0
  metadata {
    name      = "applications"
    namespace = "argocd"
  }

  spec {
    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "default"
    }

    source {
      repo_url        = "https://github.com/asprin107/sturdy-lamp.git"
      path            = "iac/k8s-local/applications"
      target_revision = "HEAD"
    }
  }

}

variable "enabled_default_apps" {
  description = "Deploy default applications."
  type        = bool
  default     = true
}

variable "argocd_info" {
  type = object({
    server_addr = string
    username    = string
    password    = string
  })
}