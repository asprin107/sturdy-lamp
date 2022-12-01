variable "name" {
  description = "Name list associated to the service."
  type = object({
    project = string
  })
}

variable "env" {
  description = "System Environment Name."
  type        = string
}

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