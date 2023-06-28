terraform {
  backend "s3" {
    bucket  = "lamp-bmt-tfstate"
    key     = "lamp-bmt-tfstate/quick/eks/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "bmt"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

provider "tls" {}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"

    host                   = module.eks_cluster.eks_cluster_values.endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.eks_cluster_values.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token","--profile", var.profile, "--cluster-name", module.eks_cluster.eks_cluster_values.name]
      command     = "aws"
    }
  }
}