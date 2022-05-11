variable "project_name" {
  description = "The project name. It used to every resources name prefix."
  type        = string
}

variable "region" {
  description = "vpc region"
  type        = string
}

variable "rule" {
  description = "Network creation rule."
  type = object({
    network = object({
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
    security_group = map(
      map(
        object({
          protocol  = string
          from_port = number
          to_port   = number
          type      = string
        })
      )
    )
  })
}