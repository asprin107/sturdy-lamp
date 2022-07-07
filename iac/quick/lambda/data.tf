data "aws_iam_policy_document" "lambda_svc_policy" {
  statement {
    effect = "Allow"
    actions = ["s3:*"]
    resources = ["*"]
  }
}