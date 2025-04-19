terraform {
  required_providers {
    argocd = {
      source  = "argoproj-labs/argocd"
      version = "~> 7"
    }
  }
}

provider "argocd" {
  server_addr = var.argocd_info.server_addr
  username    = var.argocd_info.username
  password    = var.argocd_info.password
  insecure = true
}