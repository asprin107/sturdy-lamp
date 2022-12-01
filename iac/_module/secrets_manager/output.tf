output "secret_manager_arn" {
  value = aws_secretsmanager_secret.default.arn
}

output "kms_arn" {
  value = aws_kms_key.key.arn
}

output "kms_alias" {
  value = aws_kms_alias.key_aliase.name
}