terraform {
  cloud {
    organization = "friendly-coding"

    workspaces {
      name = "quick-eks"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.10.0"
    }
  }
}

provider "aws" {
  region = var.region
}