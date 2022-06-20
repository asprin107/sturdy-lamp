terraform {
  cloud {
    organization = "friendly-coding"

    workspaces {
      name = "chaos_engineering"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.19.0"
    }
  }
}

provider "aws" {
  region = var.region
}