resource "aws_vpc" "main" {
  cidr_block           = var.rule.network.host_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  instance_tenancy = "default"

  tags = merge(
    {
      Name = "${var.project_name}-vpc"
    }
  )
}