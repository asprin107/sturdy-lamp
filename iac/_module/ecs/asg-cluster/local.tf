locals {
  asg_instance_arch = {
    ARM    = data.aws_ssm_parameter.ami-ecs-node-arm.value
    X86_64 = data.aws_ssm_parameter.ami-ecs-node-x86_64.value
  }
}