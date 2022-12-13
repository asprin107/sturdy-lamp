resource "aws_key_pair" "ec2_pub_key" {
  key_name   = var.key_name
  public_key = var.ec2_pub_key
}