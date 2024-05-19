data "aws_iam_policy_document" "trusted_external_secrets" {
  statement {
    principals {
      type = "Federated"
      identifiers = [
        var.eks.oidc_provider_arn
      ]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${trimprefix(var.eks.oidc_issuer_url, "https://")}:sub"

      values = [
        "system:serviceaccount:${var.serviceaccount.namespace}:${var.serviceaccount.name}"
      ]
    }
  }

}

data "aws_iam_policy_document" "irsa_external_secrets" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter*",
      "ssm:PutParameter",
      "ssm:DescribeParameters",
      "ssm:DeleteParameter*",
      "ssm:AddTagsToResource",
      "ssm:ListTagsForResource",
      "ssm:RemoveTagsFromResource",
      "tag:GetResources"
    ]
    resources = ["*"]
  }
}