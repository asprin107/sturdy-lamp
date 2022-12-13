resource "aws_iam_role" "lambda_svc" {
  name               = "iam-role-${var.base_name}-lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda_svc_trust.json
}

resource "aws_iam_role_policy_attachment" "lambda_svc_policy" {
  role       = aws_iam_role.lambda_svc.name
  policy_arn = aws_iam_policy.lambda_svc_policy.arn
}

resource "aws_iam_policy" "lambda_svc_policy" {
  name   = "iam-policy-${var.base_name}-lambda"
  policy = var.lambda_svc_policy
}