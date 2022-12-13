variable "essential_tags" {
  description = "Essential tags for module."
  type = object({
    Project     = string
    Service     = string
    Management  = string
    Account     = string
    Environment = string
  })
}

variable "custom_tags" {
  description = "Custom tags for module."
  type        = map(any)
  default     = {}
}

variable "eks" {
  description = "Variables for EKS cluster"
  type = object({
    subnet_ids         = set(string)
    security_group_ids = set(string)

    node_group = object({
      capacity_type   = string # ON_DEMAND | SPOT
      ami_type        = string # AL2_x86_64 | See https://docs.aws.amazon.com/eks/latest/APIReference/API_Nodegroup.html#AmazonEKS-Type-Nodegroup-amiType
      instance_types  = set(string)
      disk_size       = number
      desired_size    = number
      max_size        = number
      min_size        = number
      max_unavailable = number
    })
  })
}