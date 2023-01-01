# See https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
# See https://docs.aws.amazon.com/AmazonECS/latest/developerguide/retrieve-ecs-optimized_AMI.html

data "aws_ssm_parameter" "ami-ecs-node-x86_64" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

data "aws_ssm_parameter" "ami-ecs-node-arm" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/arm64/recommended/image_id"
}
