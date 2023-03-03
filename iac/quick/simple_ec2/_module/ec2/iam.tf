resource "aws_iam_instance_profile" "ec2_iam" {
  name = "ec2-profile-${var.project_name}-${var.subject_name}"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
  name               = "iam-role-${var.project_name}-${var.subject_name}"
  assume_role_policy = data.aws_iam_policy_document.trust_ec2.json
}

# EC2 managed with SSM
data "aws_iam_policy" "ssm-managed-policy" {
  name = "AmazonSSMManagedInstanceCore"
}
resource "aws_iam_role_policy_attachment" "instance_role_ssm_policy_att" {
  policy_arn = data.aws_iam_policy.ssm-managed-policy.arn
  role       = aws_iam_role.ec2_role.name
}
# ECR PowerUser
data "aws_iam_policy" "ecr-managed-policy" {
  name = "AmazonEC2ContainerRegistryPowerUser"
}
resource "aws_iam_role_policy_attachment" "instance_role_ecr_policy_att" {
  policy_arn = data.aws_iam_policy.ecr-managed-policy.arn
  role       = aws_iam_role.ec2_role.name
}