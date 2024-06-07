provider "aws" {
  region = var.region
}

provider "helm" {
  kubernetes {
    host                   = module.eks.eks_cluster_values.endpoint
    cluster_ca_certificate = base64decode(module.eks.eks_cluster_values.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks.eks_cluster_values.name]
    }
  }
}