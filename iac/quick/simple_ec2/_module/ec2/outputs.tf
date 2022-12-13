output "ec2_pub_key" {
  value = aws_key_pair.ec2_pub_key
}

output "public_ip" {
  value = aws_eip.service_ec2_public_ip.public_ip
}