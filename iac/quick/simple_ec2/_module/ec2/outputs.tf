output "public_ip" {
  value = aws_eip.service_ec2_public_ip.public_ip
}