variable "efs_location" {
  description = "EFS location URL."
  type        = string
}

variable "kms_codebuild" {
  description = "KMS key for codebuild."
  type        = string
}

variable "vpc_id" {
  description = "VPC id codebuild instance located."
  type        = string
}

variable "subnet_ids" {
  description = "subnet ids codebuild instance located."
  type        = list(string)
}

variable "security_group_ids" {
  description = "security group ids codebuild use."
  type        = list(string)
}

variable "profile" {
  description = "aws profile"
  type        = string
}