variable "profile" {
  description = "aws profile"
  type        = string
}

variable "region" {
  description = "region"
  type        = string
}

variable "ami" {
  description = "amazon machine image"
  type = object({
    ami_x86 = string
  })
}

variable "ec2_pub_key" {
  description = "ec2 public key"
  type        = string
}