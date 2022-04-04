variable "main_vpc_id" {
  description = "Main VPC id."
  type        = string
}

variable "project_name" {
  description = "Project Name."
  type        = string
}

variable "alb_subnet_ids" {
  description = "Subnet list placed on alb"
  type        = list(string)
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

variable "container_def" {
  description = "ECS Task Container Definition."
}