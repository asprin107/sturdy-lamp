data "aws_iam_policy_document" "lambda_svc_trust" {
  statement {
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
  }
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "lambda_function.zip"
}

data "aws_iam_policy" "lambda_default_basic" {
  name = "AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy" "lambda_default_vpc" {
  name = "AWSLambdaVPCAccessExecutionRole"
}