module "ec2" {
  source = "git::https://asprin107@github.com/asprin107/sturdy-lamp.git//iac/_module/ec2/instance-static_ip"

  #  ami              = "ami-002e2b2b1334aaf55" # aws ec2 describe-images --owners amazon --filters Name="description",Values="Amazon Linux 2*" Name="architecture",Values="x86_64" --output table
  #  ami              = data.aws_ssm_parameter.ec2-ami.value
  ami                   = "ami-05f53c2def3a51a08"
  instance_type         = "t3.large"
  key_name              = var.ec2-key-name
  list_sg               = [module.security_group.list_security_group.id]
  project_name          = var.project
  subject_name          = var.service
  subnet_id             = module.network.pub_subnet_ids[0]
  instance_profile_name = aws_iam_instance_profile.ec2.name
  root_volume_size      = "50"

  user_data_base64 = "" #base64encode(file("./ec2_init.sh"))

  depends_on = [module.ec2-key]
}

data "aws_ssm_parameter" "ec2-ami" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2022-English-Core-Base"
}

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