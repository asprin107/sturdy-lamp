terraform {
  backend "s3" {
    bucket  = "lamp-bmt-tfstate"
    key     = "lamp-bmt-tfstate/glue/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "bmt"
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