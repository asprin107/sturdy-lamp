resource "aws_key_pair" "ec2_pub_key" {
  key_name   = "${var.project_name}-ec2-key"
  public_key = var.ec2_pub_key
}