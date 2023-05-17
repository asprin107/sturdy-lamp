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