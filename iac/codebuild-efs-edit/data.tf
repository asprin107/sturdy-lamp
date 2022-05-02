data "aws_iam_policy_document" "codebuild_role" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
  }
}

data "aws_iam_policy_document" "codebuild_vpc" {
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    condition {
      test     = "StringEquals"
      values   = ["codebuild.amazonaws.com"]
      variable = "ec2:AuthorizedService"
    }
    condition {
      test = "StringEquals"
      values = [for v in var.subnet_ids: format("arn:aws:ec2:ap-northeast-1:${data.aws_caller_identity.current.account_id}:subnet/%s", v)]
      variable = "ec2:Subnet"
    }
    actions   = ["ec2:CreateNetworkInterfacePermission"]
    effect    = "Allow"
    resources = ["arn:aws:ec2:ap-northeast-1:${data.aws_caller_identity.current.account_id}:network-interface/*"]
  }
}

data "aws_iam_policy_document" "codebuild_base" {
  statement {
    resources = [
      "arn:aws:logs:ap-northeast-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${aws_codebuild_project.msa_config.name}",
      "arn:aws:logs:ap-northeast-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${aws_codebuild_project.msa_config.name}:*"
    ]
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    effect    = "Allow"
    resources = ["arn:aws:s3:::codepipeline-ap-northeast-1-*"]
  }

  statement {
    actions = [
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:UpdateReport",
      "codebuild:BatchPutTestCases",
      "codebuild:BatchPutCodeCoverages"
    ]
    effect    = "Allow"
    resources = ["arn:aws:codebuild:ap-northeast-1:${data.aws_caller_identity.current.account_id}:report-group/${aws_codebuild_project.msa_config.name}-*"]
  }
}

data "aws_iam_policy_document" "codebuild_service" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::bmt-efs-test/test",
      "arn:aws:s3:::bmt-efs-test/*"
    ]
  }
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    effect    = "Allow"
    resources = ["arn:aws:s3:::bmt-efs-test"]
  }
}

data "aws_caller_identity" "current" {}