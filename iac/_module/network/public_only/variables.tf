variable "project_name" {
  description = "The project name. It used to every resources name prefix."
  type        = string
}

variable "region" {
  description = "vpc region"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = any
}

variable "eks_tags" {
  description = "tasg for EKS"
  default     = null
  type        = object({
    sbn = object({
      pub = any
      prv = any
    })
  })
}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address."
  default     = false
  type        = bool
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
    }
  }
}