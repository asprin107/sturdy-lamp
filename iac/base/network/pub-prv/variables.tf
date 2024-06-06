variable "project" {
  description = "Project name."
  type        = string
}

variable "service" {
  description = "Service name."
  type        = string
  default     = null
}

variable "region" {
  description = "AWS region name."
  type        = string
}