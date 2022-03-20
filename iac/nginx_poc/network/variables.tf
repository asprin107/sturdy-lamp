variable "project_name" {
  description = "The project name. It used to every resources name prefix."
  type        = string
}

variable "rule" {
  description = "Network creation rule."
}

variable "tags" {
  description = "default tags."
  type = object({})
}