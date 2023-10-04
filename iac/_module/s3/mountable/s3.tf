resource "aws_s3_bucket" "mount" {
  bucket = "${local.naming_rule}-${random_string.s3-random-name.result}"
}

resource "random_string" "s3-random-name" {
  length  = 6
  lower   = true
  upper   = false
  special = false
}

resource "aws_s3_object" "folder" {
  count  = var.s3_prefix != "" ? 1 : 0
  bucket = aws_s3_bucket.mount.bucket
  key    = var.s3_prefix
  source = "/dev/null"
}

resource "aws_s3_access_point" "mount_access_point" {
  count = var.s3_access_point_enabled ? 1 : 0

  bucket = aws_s3_bucket.mount.id
  name   = "${local.naming_rule}-${random_string.s3-random-name.result}"
  vpc_configuration {
    vpc_id = var.s3_vpc_id
  }
}

resource "aws_s3control_access_point_policy" "ec2_mount" {
  count = var.s3_access_point_enabled ? 1 : 0

  access_point_arn = aws_s3_access_point.mount_access_point[0].arn
  policy = jsonencode({
    Statement = [
      {
        Sid = "AllowListBucket"
        Principal = {
          AWS = aws_iam_role.ec2_access_to_s3.arn
        }
        Effect = "Allow"
        Action = local.s3_mount_actions.list_access
        Resource = [
          aws_s3_access_point.mount_access_point[0].arn
        ]
      },
      {
        Sid = "AllowAccessToS3"
        Principal = {
          AWS = aws_iam_role.ec2_access_to_s3.arn
        }
        Effect = "Allow"
        Action = local.s3_mount_actions.object_access
        Resource = [
          "${aws_s3_access_point.mount_access_point[0].arn}/object/*"
        ]
      }
    ]
  })
}