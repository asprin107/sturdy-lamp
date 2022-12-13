variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)"
  type        = bool
  default     = false
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE"
  type        = string
  default     = "MUTABLE"
}

variable "service_name" {
  description = "Service name for container."
  type        = string
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