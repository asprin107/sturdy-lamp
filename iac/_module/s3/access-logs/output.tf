output "s3-bucket-name" {
  value = aws_s3_bucket.access_logs.bucket
}