variable "alb_name" {
  description = "List alb names can access to s3."
  type        = set(string)
}

variable "tags" {
  description = "Default tags."
  type = object({
    Project     = string
    Service     = string
    Management  = string
    Environment = string
    Account     = string
  })
}