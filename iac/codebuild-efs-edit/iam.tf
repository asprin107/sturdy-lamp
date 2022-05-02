resource "aws_iam_role" "msa_config_codebuild" {
  name                  = "codebuild-bmt-efs-test-service-role"
  assume_role_policy    = data.aws_iam_policy_document.codebuild_role.json
  force_detach_policies = false
  path                  = "/service-role/"
}

resource "aws_iam_policy" "msa_config_codebuild_vpc" {
  name        = "CodeBuildVpcPolicy-bmt-efs-test-ap-northeast-1"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodeBuild"
  policy      = data.aws_iam_policy_document.codebuild_vpc.json
}
resource "aws_iam_policy" "msa_config_codebuild_base" {
  name        = "CodeBuildBasePolicy-bmt-efs-test-ap-northeast-1"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodeBuild"
  policy      = data.aws_iam_policy_document.codebuild_base.json
}
resource "aws_iam_policy" "msa_config_codebuild_service" {
  name        = "CodeBuildS3ReadOnlyPolicy-bmt-efs-test-ap-northeast-1"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodeBuild"
  policy      = data.aws_iam_policy_document.codebuild_service.json
}

resource "aws_iam_role_policy_attachment" "msa_config_codebuild_base" {
  policy_arn = aws_iam_policy.msa_config_codebuild_base.arn
  role       = aws_iam_role.msa_config_codebuild.name
}
resource "aws_iam_role_policy_attachment" "msa_config_codebuild_vpc" {
  policy_arn = aws_iam_policy.msa_config_codebuild_vpc.arn
  role       = aws_iam_role.msa_config_codebuild.name
}
resource "aws_iam_role_policy_attachment" "msa_config_codebuild_service" {
  policy_arn = aws_iam_policy.msa_config_codebuild_service.arn
  role       = aws_iam_role.msa_config_codebuild.name
}