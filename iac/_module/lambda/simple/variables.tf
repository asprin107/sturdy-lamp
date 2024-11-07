# Lambda
variable "subnet_ids" {
  description = "subnet ids for lambda deployed"
  type        = list(string)
}

variable "security_group_ids" {
  description = "security group ids for lambda function"
  type        = list(string)
}

variable "lambda_iam_policy" {
  description = "iam policy json associated to iam role"
  type        = string
  default     = null
}

variable "lambda_description" {
  description = "description for lambda function"
  type        = string
}

variable "runtime" {
  description = "Lambda function runtime .Available values - https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime"
  type        = string
  default     = "python3.12"
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


# Common
variable "name" {
  description = "base name about all resources"
  type        = string
}

variable "tags" {
  description = "tags object"
  type        = object({})
}