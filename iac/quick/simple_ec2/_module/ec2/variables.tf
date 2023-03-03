variable "instance_type" {
  description = "ec2 instance type"
  type        = string
}

variable "instance_sg_ids" {
  description = "ec2 instance's security group ids."
  type        = set(string)
}

variable "ami" {
  description = "amazon machine iamge"
  type        = string
}

variable "key_name" {
  description = "ec2 public key name for ssh connection."
  type        = string
}

variable "project_name" {
  description = "project name."
  type        = string
}

variable "subject_name" {
  description = "subject name in project."
  type        = string
}

variable "subnet_id" {
  description = "subnet id"
  type        = string
}