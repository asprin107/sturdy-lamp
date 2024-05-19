resource "aws_ssm_parameter" "parameterstore" {
  name = "${local.naming}-github_pat"
  type = "SecureString"
  key_id = aws_kms_key.key.arn
  value = "PLACEHOLDER"
}