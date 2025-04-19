data "kubernetes_secret" "argocd" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
  depends_on = [helm_release.argocd]
}

module "addons" {
  source = "./_module/addons"

  argocd_info = {
    server_addr = "localhost:30080"
    username    = "admin"
    password    = data.kubernetes_secret.argocd.data.password
  }
}

module "applications" {
  source = "./_module/applications"

  argocd_info = {
    server_addr = "localhost:30080"
    username    = "admin"
    password    = data.kubernetes_secret.argocd.data.password
  }
}