variable "region" {
  description = "aws region."
  type        = string
}

variable "profile" {
  description = "aws profile."
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

variable "eks_vpc_id" {
  type = set(string)
}
variable "eks_subnet_ids" {
  type = set(string)
}
variable "eks_security_group_ids" {
  type = set(string)
}