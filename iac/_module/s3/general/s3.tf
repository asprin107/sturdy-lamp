resource "aws_s3_bucket" "default" {
  bucket = "${var.tags.Account}-${var.tags.Environment}-${var.tags.Project}-${var.tags.Service}"
}

resource "aws_s3_bucket_public_access_block" "private" {
  bucket = aws_s3_bucket.default.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}