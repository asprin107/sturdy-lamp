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