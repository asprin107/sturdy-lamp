variable "project_name" {
  description = "The project name. It used to every resources name prefix."
  type        = string
}

variable "region" {
  description = "aws vpc region."
  type        = string
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
