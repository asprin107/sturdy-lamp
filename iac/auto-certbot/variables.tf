variable "TFC_WORKSPACE_NAME" {
  type = string
}

variable "project_name" {
  description = "Project Name."
  type        = string
  default     = "auto-certbot"
}

variable "PUB_KEY" {
  description = "public key for access ec2."
  type        = string
}