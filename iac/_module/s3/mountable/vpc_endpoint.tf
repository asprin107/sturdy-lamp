data "aws_vpc_endpoint_service" "s3" {
  service      = "s3"
  service_type = "Interface" // Gateway, Interface, GatewayLoadBalancer (Custom service endpoint)
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  count = var.vpc_endpoint_enabled ? 1 : 0

  vpc_id            = var.s3_vpc_id
  service_name      = data.aws_vpc_endpoint_service.s3.service_name
  vpc_endpoint_type = data.aws_vpc_endpoint_service.s3.service_type

  subnet_ids = var.s3_subnet_ids

  tags = merge(var.tags, {
    Name = local.naming_rule
  })
}

resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_rt" {
  for_each = { for k, v in var.route_table_id : k => v }

  route_table_id  = each.key
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint[0].id
}

resource "aws_vpc_endpoint_policy" "s3_endpoint" {
  count = var.vpc_endpoint_enabled ? 1 : 0

  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint[0].id
  policy = jsonencode({
    Statement = [
      {
        Sid = "MountpointFullBucketAccess"
        Principal = {
          AWS = aws_iam_role.ec2_access_to_s3.arn
        }
        Effect = "Allow"
        Action = local.s3_mount_actions.list_access
        Resource = [
          aws_s3_bucket.mount.arn
        ]
      },
      {
        Sid = "MountpointFullObjectAccess"
        Principal = {
          AWS = aws_iam_role.ec2_access_to_s3.arn
        }
        Effect = "Allow"
        Action = local.s3_mount_actions.object_access
        Resource = [
          "${aws_s3_bucket.mount.arn}/*"
        ]
      }
    ]
  })
}