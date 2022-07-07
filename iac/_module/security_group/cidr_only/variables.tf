variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "list_sg_rule" {
  description = "list security group rule"
  type = list(object({
    protocol    = string
    from_port   = number
    to_port     = number
    type        = string
    cidr_blocks = list(string)
  }))
}

variable "sg_description" {
  description = "description for security group"
  type        = string
}