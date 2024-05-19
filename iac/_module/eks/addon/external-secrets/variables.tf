variable "essential_tags" {
  description = "Essential tags for module."
  type = object({
    Project     = string
    Service     = string
    Management  = string
    Account     = string
    Environment = string
  })
}

variable "custom_tags" {
  description = "Custom tags for module."
  type        = map(any)
  default     = {}
}

variable "iam" {
  description = "IAM info"
  type = object({
    role_name   = string
    policy_name = string
  })
}

variable "eks" {
  description = "Eks cluster OIDC info"
  type = object({
    oidc_provider_arn = string
    oidc_issuer_url   = string
  })
}

variable "serviceaccount" {
  description = "Service Account info"
  type = object({
    namespace = string
    name      = string
  })
}