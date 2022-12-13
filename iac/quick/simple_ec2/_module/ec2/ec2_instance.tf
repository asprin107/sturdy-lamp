resource "aws_instance" "service_ec2" {
  ami           = var.ami.ami_x86
  instance_type = var.instance_type
  key_name      = aws_key_pair.ec2_pub_key.key_name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.service_ec2_eni.id
  }

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = "20"
    volume_type = "gp2"
  }

  iam_instance_profile = aws_iam_instance_profile.ec2_iam.name

  tags = {
    Name = "ec2-${var.project_name}-${var.subject_name}"
  }
}

resource "aws_network_interface" "service_ec2_eni" {
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.public.id]

  tags = {
    Name = "eni-${var.project_name}-${var.subject_name}"
  }
}

resource "aws_eip" "service_ec2_public_ip" {
  vpc      = true
  instance = aws_instance.service_ec2.id

  tags = {
    Name = "eip-${var.project_name}-${var.subject_name}"
  }
}