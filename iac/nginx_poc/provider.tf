terraform {
  backend "remote" {
    organization = "friendly-coding"

    workspaces {
      prefix = "nginx_poc_"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = local.rule.network.region
  #  profile = var.profile
}