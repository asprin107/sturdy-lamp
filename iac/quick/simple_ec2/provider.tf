terraform {
  #  cloud {
  #    organization = "friendly-coding"
  #
  #    workspaces {
  #      name = "simple-ec2"
  #    }
  #  }

  required_providers {
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