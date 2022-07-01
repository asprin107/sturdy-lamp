terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.20.0"
      configuration_aliases = [
        aws.bmt,
        aws.dev
      ]
    }
    pgp = {
      source  = "ekristen/pgp"
      version = "0.2.4"
    }
  }

  backend "remote" {
    organization = "friendly-coding"

    workspaces {
      prefix = "iam_user_management-pgpkey"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "bmt"
}

provider "aws" {
  region  = var.region
  profile = "bmt"
  alias   = "dev"
}

provider "pgp" {}