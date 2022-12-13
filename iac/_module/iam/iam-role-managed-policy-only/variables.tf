variable "role_name" {
  description = "IAM Role name"
  type        = string
}

variable "list_user_arn_allowed_assume" {
  description = "List IAM User arn allowed assume role."
  type        = list(string)
}

variable "list_role_policies" {
  description = "All list policies arns associated role."
  type        = map(string)
}

variable "tags" {
  description = "default tags."
  type        = any
}