locals {
  fh_name                = "firehose-net-iptv-net-cloudwatch_metric" #"datadog-deliver-metric"
  access_key_for_datadog = ""                                        # KEY_FOR_DATADOG
}

resource "aws_kinesis_firehose_delivery_stream" "datadog_stream" {
  destination = "http_endpoint"
  name        = local.fh_name
  http_endpoint_configuration {
    name               = "Datadog"
    url                = "https://awsmetrics-intake.datadoghq.com/v1/input" # Datadog http_endpoint
    access_key         = local.access_key_for_datadog
    s3_backup_mode     = "FailedDataOnly"
    role_arn           = aws_iam_role.datadog_firehose_service_role.arn
    retry_duration     = 60
    buffering_interval = 60
    buffering_size     = 4

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = "/aws/kinesisfirehose/${local.fh_name}"
      log_stream_name = "DestinationDelivery"
    }
    processing_configuration {
      enabled = false
    }
    request_configuration {
      content_encoding = "GZIP"
    }
  }

  s3_configuration {
    bucket_arn          = aws_s3_bucket.failed_backup.arn
    role_arn            = aws_iam_role.datadog_firehose_service_role.arn
    buffer_interval     = 60
    buffer_size         = 4
    compression_format  = "GZIP"
    error_output_prefix = "failed"
  }
}

resource "aws_s3_bucket" "failed_backup" {
  bucket = "s3-net-iptv-net-datadog-failed-metric" #"s3-datadog-metric-streaming"
}

resource "aws_iam_role" "datadog_firehose_service_role" {
  name               = "KinesisFirehoseServiceRole-firehose-ap-northeast-2-1650507667848" #"datadog_firehose_service_role"
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.assume-firehose.json
}

resource "aws_iam_policy" "datadog_firehose_service_policy" {
  name = "KinesisFirehoseServicePolicy-${local.fh_name}-ap-northeast-2" # datadog_firehose_service_policy
  path = "/service-role/"
  policy = jsonencode(
    {
      "Statement" : [
        {
          "Action" : [
            "glue:GetTable",
            "glue:GetTableVersion",
            "glue:GetTableVersions"
          ],
          "Effect" : "Allow",
          "Resource" : [
            "arn:aws:glue:ap-northeast-2:${data.aws_caller_identity.current.account_id}:catalog",
            "arn:aws:glue:ap-northeast-2:${data.aws_caller_identity.current.account_id}:database/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%",
            "arn:aws:glue:ap-northeast-2:${data.aws_caller_identity.current.account_id}:table/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%"
          ],
          "Sid" : ""
        },
        {
          "Action" : [
            "s3:AbortMultipartUpload",
            "s3:GetBucketLocation",
            "s3:GetObject",
            "s3:ListBucket",
            "s3:ListBucketMultipartUploads",
            "s3:PutObject"
          ],
          "Effect" : "Allow",
          "Resource" : [
            "arn:aws:s3:::${aws_s3_bucket.failed_backup.bucket}",
            "arn:aws:s3:::${aws_s3_bucket.failed_backup.bucket}/*"
          ],
          "Sid" : ""
        },
        {
          "Action" : [
            "lambda:InvokeFunction",
            "lambda:GetFunctionConfiguration"
          ],
          "Effect" : "Allow",
          "Resource" : "arn:aws:lambda:ap-northeast-2:${data.aws_caller_identity.current.account_id}:function:%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%",
          "Sid" : ""
        },
        {
          "Action" : [
            "kms:GenerateDataKey",
            "kms:Decrypt"
          ],
          "Condition" : {
            "StringEquals" : {
              "kms:ViaService" : "s3.ap-northeast-2.amazonaws.com"
            },
            "StringLike" : {
              "kms:EncryptionContext:aws:s3:arn" : [
                "arn:aws:s3:::%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%/*",
                "arn:aws:s3:::%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%"
              ]
            }
          },
          "Effect" : "Allow",
          "Resource" : [
            "arn:aws:kms:ap-northeast-2:${data.aws_caller_identity.current.account_id}:key/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%"
          ]
        },
        {
          "Action" : [
            "logs:PutLogEvents"
          ],
          "Effect" : "Allow",
          "Resource" : [
            "arn:aws:logs:ap-northeast-2:${data.aws_caller_identity.current.account_id}:log-group:/aws/kinesisfirehose/${local.fh_name}:log-stream:*",
            "arn:aws:logs:ap-northeast-2:${data.aws_caller_identity.current.account_id}:log-group:%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%:log-stream:*"
          ],
          "Sid" : ""
        },
        {
          "Action" : [
            "kinesis:DescribeStream",
            "kinesis:GetShardIterator",
            "kinesis:GetRecords",
            "kinesis:ListShards"
          ],
          "Effect" : "Allow",
          "Resource" : "arn:aws:kinesis:ap-northeast-2:${data.aws_caller_identity.current.account_id}:stream/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%",
          "Sid" : ""
        },
        {
          "Action" : [
            "kms:Decrypt"
          ],
          "Condition" : {
            "StringEquals" : {
              "kms:ViaService" : "kinesis.ap-northeast-2.amazonaws.com"
            },
            "StringLike" : {
              "kms:EncryptionContext:aws:kinesis:arn" : "arn:aws:kinesis:ap-northeast-2:${data.aws_caller_identity.current.account_id}:stream/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%"
            }
          },
          "Effect" : "Allow",
          "Resource" : [
            "arn:aws:kms:ap-northeast-2:${data.aws_caller_identity.current.account_id}:key/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%"
          ]
        }
      ],
      "Version" : "2012-10-17"
    }
  )
}

resource "aws_iam_role_policy_attachment" "firehose-service-role-policy" {
  role       = aws_iam_role.datadog_firehose_service_role.name
  policy_arn = aws_iam_policy.datadog_firehose_service_policy.arn
}

data "aws_iam_policy_document" "assume-firehose" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["firehose.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_caller_identity" "current" {}