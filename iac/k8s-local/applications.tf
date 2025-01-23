data "kubernetes_secret" "argocd" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
}

module "apps" {
  source = "./_module/apps"

  argocd_info = {
    server_addr = "localhost:30080"
    username    = "admin"
    password    = data.kubernetes_secret.argocd.data.password
  }
}