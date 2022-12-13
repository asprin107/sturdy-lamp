variable "instance_type" {
  description = "ec2 instance type"
  type        = string
}

variable "ami" {
  description = "amazon machine iamge"
  type = object({
    ami_x86 = string
  })
}

variable "ec2_pub_key" {
  description = "ec2 public key for ssh connection."
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

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "subnet_id" {
  description = "subnet id"
  type        = string
}