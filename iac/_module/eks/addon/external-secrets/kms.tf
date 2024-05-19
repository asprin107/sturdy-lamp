resource "aws_kms_key" "key" {
  description = "KMS for Github PAT stored in parameter store."

  tags = local.tags
}

resource "aws_kms_alias" "key" {
  target_key_id = aws_kms_key.key.id
}