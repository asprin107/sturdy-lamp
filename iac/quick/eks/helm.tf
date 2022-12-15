resource "helm_release" "argocd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"
  name  = "argocd"
  namespace = "default"

  version = "5.16.5"

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}