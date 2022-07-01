terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.6.0"
    }
    pgp = {
      source  = "ekristen/pgp"
      version = "0.2.4"
    }
  }
}