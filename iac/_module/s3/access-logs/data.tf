data "aws_caller_identity" "current" {}

data "aws_elb_service_account" "aws_elb" {
  #  region = var.region # default region same as provider.
}

data "aws_iam_policy_document" "alb_access_s3_dynamic" {
  for_each = { for k, v in var.alb_name : v => null }

  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_elb_service_account.aws_elb.id}:root"]
    }
    effect    = "Allow"
    resources = ["arn:aws:s3:::${aws_s3_bucket.access_logs.bucket}/${each.key}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    actions   = ["s3:PutObject"]
  }

  statement {
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    effect    = "Allow"
    resources = ["arn:aws:s3:::${aws_s3_bucket.access_logs.bucket}/${each.key}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    actions   = ["s3:PutObject"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

data "aws_iam_policy_document" "alb_access_s3_common" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    effect    = "Allow"
    resources = ["arn:aws:s3:::${aws_s3_bucket.access_logs.bucket}"]
    actions   = ["s3:GetBucketAcl"]
  }
  source_policy_documents = [for k, v in data.aws_iam_policy_document.alb_access_s3_dynamic : v.json]
}