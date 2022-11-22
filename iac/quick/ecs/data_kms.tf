data "aws_kms_key" "managed_aws_seceretsmanager_key" {
  key_id = "alias/aws/secretsmanager"
}