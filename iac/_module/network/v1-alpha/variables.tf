variable "name" {
  description = "This used for all resource names."
  type        = string
}

variable "region" {
  description = "AWS vpc region."
  type        = string
}

variable "eks_enabled" {
  type    = bool
  default = true
}

variable "rule" {
  description = "Network creation rule."
  type = object({
    host_cidr = string
    subnets = object({
      newbits         = number
      available_zones = list(string)
      pub = object({
        amount = number
        max    = number
      })
      prv = object({
        amount = number
        max    = number
      })
    })
  })
  default = {
    host_cidr = "10.0.0.0/16"
    subnets = {
      newbits         = 6
      available_zones = ["a", "c"]
      pub = {
        amount = 2
        max    = 20
      }
      prv = {
        amount = 2
        max    = 44
      }
    }
  }
}

variable "tags" {
  description = "Additional tags"
  type        = map(any)
  default     = {}
}
