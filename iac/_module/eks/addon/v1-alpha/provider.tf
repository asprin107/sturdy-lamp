terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2"
    }
  }
}