data "aws_iam_policy_document" "user_assume_policy" {
  statement {
    sid = "AllowAssumeRole"
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = var.list_role_arn_allowed_assume
  }

  statement {
    sid = "IpRestriction"
    condition {
      test     = "NotIpAddress"
      values   = var.list_allowed_ip
      variable = "aws:SourceIp"
    }
    condition {
      test     = "Bool"
      values   = ["false"]
      variable = "aws:ViaAWSService"
    }
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]
  }
}