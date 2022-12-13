resource "aws_iam_user" "user" {
  name = var.user_name
  path = var.path
  tags = var.tags

  force_destroy = true # Because of MFA. If MFA device enrolled, cannot delete iam_user before remove mfa device
}

resource "aws_iam_user_policy_attachment" "directly_attached_managed_policy" {
  count      = length(var.list_directly_attached_managed_policy)
  user       = aws_iam_user.user.name
  policy_arn = var.list_directly_attached_managed_policy[count.index]
}

resource "aws_iam_user_policy" "user_assume_policy" {
  name   = "user_assume_policy"
  policy = data.aws_iam_policy_document.user_assume_policy.json
  user   = aws_iam_user.user.name
}

resource "aws_iam_user_policy_attachment" "user_mfa_policy" {
  policy_arn = var.mfa_policy_arn
  user       = aws_iam_user.user.name
}

resource "aws_iam_user_login_profile" "login_profile" {
  user                    = aws_iam_user.user.name
  pgp_key                 = pgp_key.user_key.public_key_base64
  password_reset_required = true

  lifecycle {
    ignore_changes = [password_reset_required]
  }

}

resource "aws_iam_access_key" "access_key" {
  user    = aws_iam_user.user.name
  pgp_key = pgp_key.user_key.public_key_base64
}