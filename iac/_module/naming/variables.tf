variable "project" {
  description = "Project name."
  type        = string
}

variable "service" {
  description = "Service name."
  type        = string
  default     = null
}

variable "prefix" {
  description = "The initial modifier of the name you want to create."
  type        = string
  default     = null
}

variable "suffix" {
  description = "The last modifier of the name you want to create."
  type        = string
  default     = null
}

variable "random_string" {
  description = "Random string introduced to prevent collisions. If not specified, it will be created."
  type        = string
  default     = null
}

variable "random_length" {
  description = "Number of digits of the random string to be created."
  type        = number
  default     = 6
}

variable "separator" {
  description = "Separator used to create a name."
  type        = string
  default     = "-"
}