locals {
  ec2_info = jsondecode(file("./ec2_info.yaml"))
}