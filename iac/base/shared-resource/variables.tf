variable "region" {
  description = "AWS region name"
  type        = string
}

variable "profile" {
  description = "AWS profile"
  type        = string
}

variable "project" {
  description = "Project name (Main category)"
  type        = string
}

variable "aws_account" {
  description = "AWS account alias for identification. (Doesn't have to be same as real aws account alias value)"
  type        = string
}

variable "env" {
  description = "Environment about service."
  type        = string
}

variable "service" {
  description = "Service name (Sub category)"
  type        = string
}