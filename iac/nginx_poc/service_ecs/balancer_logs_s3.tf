resource "aws_s3_bucket" "alb_access_log" {
  bucket = "${var.project_name}-access-log"
}