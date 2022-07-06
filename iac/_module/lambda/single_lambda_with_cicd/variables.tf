# Lambda
variable "subnet_ids" {
  description = "subnet ids for lambda deployed"
  type        = list(string)
}

variable "security_group_ids" {
  description = "security group ids for lambda function"
  type        = list(string)
}

variable "role_arn" {
  description = "iam role arn for lambda function."
  type        = string
}

variable "lambda_description" {
  description = "description for lambda function"
  type        = string
}

variable "runtime" {
  description = "lambda function runtime"
  type        = string
  default     = "python3.9"
}

variable "environment_variables" {
  description = "environment map"
  type        = object({})
  default     = {}
}

variable "handler" {
  description = "lambda function entrypoint in source code."
  type        = string
  # https://docs.aws.amazon.com/ko_kr/lambda/latest/dg/python-handler.html
  default = "lambda_function.lambda_handler" # AWS lambda python default handler. it means the function name of lambda_handler in lambda_function.py in
}

variable "lambda_svc_policy_json" {
  description = "iam policy json associated to iam role"
  type = object({
    statement = object({
      principals = object({
        identifiers = list(string)
        type        = string
      })
      effect  = string
      actions = list(string)
    })
  })
}


# S3
#variable "bucket_name" {
#  description = "s3 bucket name"
#  type        = string
#}
#
#variable "source_file" {
#  description = "lambda function source file."
#  type        = string
#}
#
#variable "source_path" {
#  description = "lambda function source path."
#  type        = string
#  default     = ""
#}
#
#variable "object_version" {
#  description = "lambda function source version."
#  type = string
#}


# Common
variable "base_name" {
  description = "base name about all resources"
  type        = string
}

variable "tags" {
  description = "tags object"
  type        = object({})
}