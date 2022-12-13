resource "aws_iam_instance_profile" "instance_profile" {
  name = "ecs-ec2-profile-${local.naming_convention}"
  role = aws_iam_role.instance_role.name

  tags = module.default_tags.tags
}

resource "aws_iam_role" "instance_role" {
  name               = "role-ecs-ec2-${local.naming_convention}"
  assume_role_policy = data.aws_iam_policy_document.ec2_profile.json

  tags = module.default_tags.tags
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

# EC2 can servie ecs container
data "aws_iam_policy" "ecs-managed-policy" {
  name = "AmazonEC2ContainerServiceforEC2Role"
}
resource "aws_iam_role_policy_attachment" "instance_role_ecs_policy_att" {
  policy_arn = data.aws_iam_policy.ecs-managed-policy.arn
  role       = aws_iam_role.instance_role.name
}
