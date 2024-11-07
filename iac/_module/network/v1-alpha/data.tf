# Reference : https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSecurityGroups.html
data "aws_security_group" "default_sg" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
  filter {
    name = "vpc-id"
    values = [aws_vpc.main.id]
  }
}
