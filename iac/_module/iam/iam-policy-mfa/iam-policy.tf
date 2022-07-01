resource "aws_iam_policy" "mfa_policy" {
  name        = "iam-policy-mfa-default"
  policy      = data.aws_iam_policy_document.user_basic_policy.json
  description = "Default iam policy for enforce MFA."
}