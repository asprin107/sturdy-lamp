resource "aws_s3_bucket" "access_logs" {
  bucket = "${var.tags.Project}-access-logs-${random_string.s3-random-name.result}"
}

resource "aws_s3_bucket_policy" "alb_access" {
  bucket = aws_s3_bucket.access_logs.bucket
  policy = data.aws_iam_policy_document.alb_access_s3_common.json
}

resource "random_string" "s3-random-name" {
  length  = 6
  lower   = true
  upper   = false
  special = false
}