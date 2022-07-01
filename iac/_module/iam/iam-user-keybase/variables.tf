variable "user_name" {
  description = "IAM Uesr name. It must be identifier. It can be email address."
  type        = string
}

variable "path" {
  description = "path for categorize users."
  type        = string
}

variable "list_role_arn_allowed_assume" {
  description = "list role arn allowed to assume."
  type        = list(string)
}

variable "list_directly_attached_managed_policy" {
  description = "list managed policy arn about directly attached to the user."
  type        = list(string)
}

variable "mfa_policy_arn" {
  description = "IAM policy arn for MFA"
  type        = string
}

variable "list_allowed_ip" {
  description = "allowed ip list"
  type        = list(string)
}

variable "keybase_name" {
  description = "keybase user name"
  type        = string
}

variable "tags" {
  description = "default tags."
  type        = any
}