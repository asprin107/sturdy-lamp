resource "pgp_key" "user_key" {
  name    = "${var.user_name}-pgp_key"
  email   = var.user_name
  comment = "\"${var.user_name}\" user's pgp key."
}

data "pgp_decrypt" "pgp_key" {
  private_key         = pgp_key.user_key.private_key
  ciphertext          = aws_iam_user_login_profile.login_profile.encrypted_password
  ciphertext_encoding = "base64"
}