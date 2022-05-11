terraform {
  cloud {
    organization = "friendly-coding"

    workspaces {
      name = "simple-ec2"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}