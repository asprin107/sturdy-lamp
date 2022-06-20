variable "instance_type" {
  description = "ec2 instance type"
  type        = string
}

variable "instance_profile_name" {
  description = "ec2 instance profile name"
  type        = string
}

variable "ami" {
  description = "amazon machine iamge"
  type = object({
    ami_x86 = string
  })
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

variable "key_name" {
  description = "ec2_key_name"
  type        = string
}

variable "list_sg" {
  description = "list security group attached to ec2"
  type        = list(string)
}