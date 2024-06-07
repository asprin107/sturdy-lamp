resource "helm_release" "external-secrets" {
  count            = var.external-secrets-enabled ? 1 : 0
  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets/external-secrets"
  version          = var.external-secrets-addon_version
  namespace        = var.external-secrets-namespace
  create_namespace = true
}

resource "aws_iam_role" "external-secrets" {
  count              = var.external-secrets-enabled ? 1 : 0
  name               = "${var.name}-ExternalSecrets"
  assume_role_policy = data.aws_iam_policy_document.external-secrets-trusted[0].json
  tags = merge(
    var.tags
  )
}
resource "aws_iam_role_policy" "external-secrets" {
  count  = var.external-secrets-enabled ? 1 : 0
  name   = "${var.name}-ExternalSecrets"
  role   = aws_iam_role.external-secrets[0].id
  policy = data.aws_iam_policy_document.external-secrets-policy[0].json
}
data "aws_iam_policy_document" "external-secrets-trusted" {
  count = var.external-secrets-enabled ? 1 : 0
  statement {
    principals {
      type = "Federated"
      identifiers = [
        var.eks_oidc_provider_arn
      ]
    }
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      values   = ["system:serviceaccount:${var.external-secrets-namespace}:external-secrets-sa"]
      variable = "${replace(var.eks_oidc_issuer_url, "https://", "")}:sub"
    }
    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "${replace(var.eks_oidc_issuer_url, "https://", "")}:aud"
    }
  }
}
data "aws_iam_policy_document" "external-secrets-policy" {
  count = var.external-secrets-enabled ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:CreateSecret",
      "secretsmanager:PutSecretValue",
      "secretsmanager:TagResource",
      "secretsmanager:DeleteSecret"
    ]
    resources = var.external-secrets-target_secretsmanager != [] ? var.external-secrets-target_secretsmanager : ["arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
  }
}


variable "external-secrets-enabled" {
  type    = bool
  default = true
}
variable "external-secrets-addon_version" {
  type    = string
  default = "0.9.19"
}
variable "external-secrets-target_secretsmanager" {
  description = "Default value is \"arn:aws:secretsmanager:$\\{data.aws_region.current.name\\}:$\\{data.aws_caller_identity.current.account_id\\}:*\""
  type        = set(string)
  default     = []
}
variable "external-secrets-namespace" {
  description = ""
  type        = string
  default     = "kube-system"
}