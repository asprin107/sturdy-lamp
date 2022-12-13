resource "aws_kms_key" "lambda_env" {
  description              = "KMS key for lambda"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"

  policy              = data.aws_iam_policy_document.lambda_env_kms.json
  enable_key_rotation = true
  is_enabled          = true
  multi_region        = false

  tags = var.tags
}

resource "aws_kms_alias" "key_alias" {
  name          = "alias/kms-${var.base_name}-lambda"
  target_key_id = aws_kms_key.lambda_env.id
}
