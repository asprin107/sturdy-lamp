data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "task_execution_trust" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "task_execution_permissions" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "ssm:GetParameters",
      "kms:Decrypt"
    ]
    effect    = "Allow"
    resources = ["*"]
    #    resources = [
    #      aws_secretsmanager_secret.ecs.arn,
    #      "${aws_secretsmanager_secret.ecs.arn}/*",
    #      data.aws_kms_key.managed_aws_seceretsmanager_key.arn
    #    ]
  }
}


data "aws_iam_policy_document" "task_trust" {
  statement {
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "task_permissions" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "codedeploy-ecs-trust" {
  statement {
    principals {
      identifiers = ["codedeploy.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
  }
}

data "aws_iam_policy" "codedeploy" {
  name = "AWSCodeDeployRoleForECS"
}


data "aws_elb_service_account" "aws_elb" {
  #  region = var.region # default region same as provider.
}

data "aws_iam_policy_document" "alb_access_s3" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_elb_service_account.aws_elb.id}:root"]
    }
    effect    = "Allow"
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_access_log.bucket}/${local.alb_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    actions   = ["s3:PutObject"]
  }

  statement {
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    effect    = "Allow"
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_access_log.bucket}/${local.alb_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    actions   = ["s3:PutObject"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    effect    = "Allow"
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_access_log.bucket}"]
    actions   = ["s3:GetBucketAcl"]
  }
}