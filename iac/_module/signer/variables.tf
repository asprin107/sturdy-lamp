variable "signer_profile_name" {
  description = "AWS Signer profile name. It must be uniqued in each account."
  type        = string
}

variable "platform_id" {
  description = "Check platform id using `aws signer list-signing-platforms`"
  type        = string
  default     = "Notation-OCI-SHA384-ECDSA" // for Notation.
}

variable "signature_validity_period" {
  type = list(object({
    type  = string
    value = number
  }))
  default = []
}

variable "signing_material" {
  type = list(object({
    certificate_arn = string
  }))
  default = []
}

variable "tags" {
  description = "Additional tags"
  type        = map(any)
  default     = {}
}