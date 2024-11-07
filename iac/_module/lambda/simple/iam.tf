resource "aws_iam_role" "lambda" {
  name               = "lambda-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.lambda_svc_trust.json
}

resource "aws_iam_role_policy_attachment" "lambda_default_basic" {
  role       = aws_iam_role.lambda.name
  policy_arn = data.aws_iam_policy.lambda_default_basic.arn
}

resource "aws_iam_role_policy_attachment" "lambda_default_vpc" {
  role       = aws_iam_role.lambda.name
  policy_arn = data.aws_iam_policy.lambda_default_vpc.arn
}


resource "aws_iam_role_policy_attachment" "lambda_svc_policy" {
  count      = var.lambda_iam_policy != null ? 1 : 0
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_svc_policy[0].arn
}

resource "aws_iam_policy" "lambda_svc_policy" {
  count  = var.lambda_iam_policy != null ? 1 : 0
  name   = "lambda-${var.name}"
  policy = var.lambda_iam_policy
}