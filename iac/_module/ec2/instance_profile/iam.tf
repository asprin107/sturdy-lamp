resource "aws_iam_instance_profile" "ec2_iam" {
  name = "ec2-profile-${var.project_name}-${var.subject_name}"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
  name               = "iam-role-${var.project_name}-${var.subject_name}"
  assume_role_policy = data.aws_iam_policy_document.trust_ec2.json
}

resource "aws_iam_policy" "ec2_role_policy" {
  name   = "iam-role-policy-${var.project_name}-${var.subject_name}"
  policy = data.aws_iam_policy_document.ec2_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ec2_role_policy" {
  policy_arn = aws_iam_policy.ec2_role_policy.arn
  role       = aws_iam_role.ec2_role.name
}