variable "project" {
  description = "Project name (Main category)"
  type        = string
}

variable "aws_profile" {
  description = "AWS Profile"
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