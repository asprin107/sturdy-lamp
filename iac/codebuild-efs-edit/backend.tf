#terraform {
#  backend "remote" {
#    organization = "friendly-coding"
#
#    workspaces {
#      prefix = "codebuild-efs-edit"
#    }
#  }
#
#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = "~> 4.6.0"
#    }
#  }
#}
