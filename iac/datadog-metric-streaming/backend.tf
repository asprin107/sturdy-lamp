terraform {
  #  cloud {
  #    organization = "friendly-coding"
  #
  #    workspaces {
  #      name = "datadog-metric-streaming"
  #    }
  #  }
  backend "local" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.10.0"
    }
  }
}