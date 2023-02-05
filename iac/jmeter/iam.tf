resource "aws_iam_instance_profile" "ec2" {
  name = "ec2-profile-${var.project}-${var.service}"
  role = aws_iam_role.instance_role.name

  tags = module.tags.tags
}
resource "aws_iam_role" "instance_role" {
  name               = "role-ec2-${var.project}-${var.service}"
  assume_role_policy = data.aws_iam_policy_document.ec2_profile.json

  tags = module.tags.tags
}
data "aws_iam_policy_document" "ec2_profile" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
  }
}

# EC2 managed with SSM
data "aws_iam_policy" "ssm-managed-policy" {
  name = "AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "instance_role_ssm_policy_att" {
  policy_arn = data.aws_iam_policy.ssm-managed-policy.arn
  role       = aws_iam_role.instance_role.name
}