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