resource "aws_iam_role" "lambda" {
  name               = "lambda-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.lambda_svc_trust.json
}

resource "aws_iam_role_policy_attachment" "lambda_svc_policy" {
  count      = var.lambda_iam_policy != null ? 1 : 0
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_svc_policy.arn
}

resource "aws_iam_policy" "lambda_svc_policy" {
  count  = var.lambda_iam_policy != null ? 1 : 0
  name   = "lambda-${var.name}"
  policy = var.lambda_iam_policy
}