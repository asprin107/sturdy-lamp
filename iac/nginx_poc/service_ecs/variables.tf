variable "main_vpc_id" {
  description = "Main VPC id."
  type        = string
}

variable "project_name" {
  description = "Project Name."
  type        = string
}

variable "alb_subnets" {
  description = "Subnet list placed on alb"
  type        = list(object({}))
}

variable "alb_sg_rules" {
  description = "List of security group rule."
  type = map(object({
    protocol  = string
    from_port = number
    to_port   = number
    type      = string
  }))
}

variable "tags" {
  description = "Default tags."
  type        = object({})
}