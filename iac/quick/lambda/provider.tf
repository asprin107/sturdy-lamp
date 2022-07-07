terraform {
  cloud {
    organization = "friendly-coding"

    workspaces {
      name = "quick-lambda"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.21.0"
    }
  }
}

provider "aws" {
  region  = var.region
}