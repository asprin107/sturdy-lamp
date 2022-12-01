resource "aws_kms_key" "key" {
  description             = var.description
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = var.maintenance_date
  is_enabled              = true

  policy = data.aws_iam_policy_document.key_policy.json

  tags = var.tags
}

resource "aws_kms_alias" "key_aliase" {
  name          = "alias/${local.naming_convention}-${var.purpose}"
  target_key_id = aws_kms_key.key.id
}