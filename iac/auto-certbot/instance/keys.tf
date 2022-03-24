resource "aws_key_pair" "certbot_apache_key" {
  key_name   = "certbot-ec2-key"
  public_key = var.PUB_KEY
}