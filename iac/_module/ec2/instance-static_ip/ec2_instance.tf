resource "aws_instance" "service_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.service_ec2_eni.id
  }

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = var.root_volume_size
    volume_type = "gp2"
  }

  iam_instance_profile = var.instance_profile_name != null ? var.instance_profile_name : ""

  tags = {
    Name = "${var.project_name}-${var.subject_name}"
  }
}

resource "aws_network_interface" "service_ec2_eni" {
  subnet_id       = var.subnet_id
  security_groups = var.list_sg

  tags = {
    Name = "${var.project_name}-${var.subject_name}"
  }
}

resource "aws_eip" "service_ec2_public_ip" {
  vpc      = true
  instance = aws_instance.service_ec2.id

  tags = {
    Name = "${var.project_name}-${var.subject_name}"
  }
}