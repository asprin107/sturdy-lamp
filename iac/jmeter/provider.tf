terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

provider "tls" {
}