resource "aws_codebuild_project" "msa_config" {
  name           = "bmt-efs-test"
  service_role   = aws_iam_role.msa_config_codebuild.arn
  encryption_key = var.kms_codebuild
  badge_enabled  = false
  build_timeout  = 60
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }
  source {
    type      = "NO_SOURCE"
    buildspec = file("_resources/buildspec.yaml")
  }
  file_system_locations {
    identifier    = "config_efs"
    location      = var.efs_location
    mount_options = "nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2"
    mount_point   = "/mnt/efs"
    type          = "EFS"
  }
  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
    s3_logs {
      status = "DISABLED"
    }
  }
  cache {
    type = "NO_CACHE"
  }
  vpc_config {
    vpc_id             = var.vpc_id
    subnets            = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
}