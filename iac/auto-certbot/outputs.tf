output "ec2_ip" {
  value = aws_eip.static-ip-for-certbot.public_ip
}