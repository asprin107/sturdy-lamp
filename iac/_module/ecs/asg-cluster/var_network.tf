variable "filter_vpc_name" {
  description = "VPC name filter."
  type        = set(string)
}

variable "filter_sbn_name" {
  description = "Subnet name filter."
  type        = set(string)
}