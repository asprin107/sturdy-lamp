variable "project" {
  description = "Project name (Main category)"
  type        = string
}

variable "env" {
  description = "Environment about service."
  type        = string
}

variable "service" {
  description = "Service name (Sub category)"
  type        = string
}

variable "aws_profile" {
  description = "AWS Profile"
  type        = string
}

variable "aws_region" {
  description = "AWS Region."
  type        = string
}

variable "ec2" {
  description = "EC2 Information."
  type = object({
    instance_type = string
    key_name      = string
    list_sg       = list(string)
    subnet_id     = string
  })
}

variable "s3_vpc_id" {
  description = "VPC id allowed access to s3."
  type        = string
}

variable "s3_prefix" {
  description = "S3 bucket prefix."
  type        = string
}

variable "route_table_id" {
  description = "List route table id that access allow to s3."
  type        = map(object({}))
}

variable "local_mount_path" {
  description = "Mount path in EC2 instance."
  type        = string
}