data "aws_iam_policy_document" "key_policy" {
  statement {
    sid = "EnableIAMuserPermissions."
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
  }
  statement {
    sid = "Allow access through AWS Secrets Manager for all principals in the account that are authorized to use AWS Secrets Manager"
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:CreateGrant",
      "kms:DescribeKey"
    ]
    condition {
      test     = "StringEquals"
      values   = ["secretsmanager.${data.aws_region.current.name}.amazonaws.com"]
      variable = "kms:ViaService"
    }
    condition {
      test     = "StringEquals"
      values   = [data.aws_caller_identity.current.account_id]
      variable = "kms:CallerAccount"
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}