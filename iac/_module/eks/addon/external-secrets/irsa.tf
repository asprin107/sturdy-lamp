resource "aws_iam_role" "irsa_external_secrets" {
  name               = var.iam.role_name
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.trusted_external_secrets.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  ]

  tags = local.tags
}

resource "aws_iam_policy" "irsa_external_secrets" {
  name   = var.iam.policy_name
  policy = data.aws_iam_policy_document.irsa_external_secrets.json
}

resource "aws_iam_role_policy_attachment" "irsa_external_secrets" {
  role       = aws_iam_role.irsa_external_secrets.name
  policy_arn = aws_iam_policy.irsa_external_secrets.arn
}

