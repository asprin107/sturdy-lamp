variable "instance_type" {
  description = "ec2 instance type"
  type        = string
}

variable "instance_profile_name" {
  description = "ec2 instance profile name"
  type        = string
  default     = null
}

variable "root_volume_size" {
  description = "root volume size (GB)"
  type        = string
  default     = "20"
}

variable "ami" {
  description = "amazon machine iamge"
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

variable "key_name" {
  description = "ec2_key_name"
  type        = string
}

variable "list_sg" {
  description = "list security group attached to ec2"
  type        = list(string)
}

variable "user_data_base64" {
  description = "ec2 user data for launch instance encoded with base64"
  type        = string
  default     = null
}