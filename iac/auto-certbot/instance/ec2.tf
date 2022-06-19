resource "aws_instance" "certbot-apache" {
  ami           = var.ami
  instance_type = var.type
  key_name      = aws_key_pair.certbot_apache_key.key_name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.certbot-apache.id
  }

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = "20"
    volume_type = "gp2"
  }

  tags = {
    Name = "ec2-${var.project_name}"
  }
}

resource "aws_network_interface" "certbot-apache" {
  subnet_id       = var.public_sbn_id
  security_groups = [var.public_web_sg_id]

  tags = {
    Name = "eni-${var.project_name}"
  }
}

resource "aws_eip_association" "certbot_ec2_ip" {
  instance_id   = aws_instance.certbot-apache.id
  allocation_id = var.eip_id
}