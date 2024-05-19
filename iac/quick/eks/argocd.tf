resource "helm_release" "argocd" {
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  version = "6.7.18"

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}