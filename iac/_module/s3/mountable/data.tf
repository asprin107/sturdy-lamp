locals {
  s3_mount_actions = {
    list_access = [
      "s3:ListBucket"
    ]
    object_access = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:DeleteObject"
    ]
  }
}

data "aws_iam_policy_document" "ec2_trusted" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
  }
}

data "aws_iam_policy_document" "ec2_access_to_s3" {
  statement {
    sid     = "MountpointFullBucketAccess"
    effect  = "Allow"
    actions = local.s3_mount_actions.list_access
    resources = [
      aws_s3_bucket.mount.arn
    ]
  }
  statement {
    sid     = "MountpointFullObjectAccess"
    effect  = "Allow"
    actions = local.s3_mount_actions.object_access
    resources = [
      "${aws_s3_bucket.mount.arn}/*"
    ]
  }
}