resource "aws_iam_role" "ec2_access_to_s3" {
  name               = "iam-role-${local.naming_rule}"
  assume_role_policy = data.aws_iam_policy_document.ec2_trusted.json
}

resource "aws_iam_role_policy" "ec2_access_to_s3" {
  name   = "AccessToS3ForMount"
  role   = aws_iam_role.ec2_access_to_s3.id
  policy = data.aws_iam_policy_document.ec2_access_to_s3.json
}

resource "aws_iam_instance_profile" "ec2_access_to_s3" {
  name = "ec2-profile-${local.naming_rule}"
  role = aws_iam_role.ec2_access_to_s3.name
}