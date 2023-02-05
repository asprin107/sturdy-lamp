data "aws_ssm_parameter" "jmeter-client-ami" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2022-English-Full-Base"
}

data "aws_ssm_parameter" "jmeter-server-ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}