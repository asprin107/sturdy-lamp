resource "aws_s3_bucket" "alb_access_log" {
  bucket = "${var.project}-access-log"
}

resource "aws_s3_bucket_policy" "alb_access" {
  bucket = aws_s3_bucket.alb_access_log.bucket
  policy = data.aws_iam_policy_document.alb_access_s3.json
}