data "aws_iam_policy_document" "iam_role_trust_relation" {
  statement {
    sid = "TrustAssumeRoleFromSecurityAccount"
    principals {
      type        = "AWS"
      identifiers = var.list_user_arn_allowed_assume
    }
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
  }
}