variable "tags" {
  description = "Default tags."
  type = object({
    Project     = string
    Service     = string
    Environment = string
    Account     = string
    Management  = string
  })
}