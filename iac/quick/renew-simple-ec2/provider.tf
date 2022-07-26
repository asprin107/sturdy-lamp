terraform {
  cloud {
    organization = "friendly-coding"

    workspaces {
      name = "quick-simple-ec2"
    }
  }

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.23.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "tls" {
}