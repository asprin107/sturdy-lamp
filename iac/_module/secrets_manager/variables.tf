variable "purpose" {
  description = "Simple purpose to identify."
  type        = string
}

variable "description" {
  description = "Description for security resources."
  type        = string
}

variable "maintenance_date" {
  description = "The date duration can be recovered. Resources aren't deleted in this period."
  type        = number
  default     = 7
}

variable "tags" {
  description = "Default tags."
  type = object({
    Project     = string
    Management  = string
    Environment = string
    Account     = string
  })
}