terraform {
  backend "s3" {
    bucket         = "lamp-bmt-tfstate"
    key            = "lamp-bmt-tfstate/base/network/pub-only/terraform.tfstate"
    region         = "ap-northeast-1"
    profile        = "bmt"
    dynamodb_table = "terraform-lock"
  }

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