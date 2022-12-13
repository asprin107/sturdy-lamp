resource "aws_secretsmanager_secret" "default" {
  name                    = "${local.naming_convention}-${var.purpose}"
  description             = var.description
  kms_key_id              = aws_kms_key.key.id
  recovery_window_in_days = var.maintenance_date

  tags = var.tags
}