variable "eks_cluster_name" {
  description = "This tags indicate associated security group is used for which EKS cluster."
  type        = string
}

variable "eks_node_sg_scope" {
  description = "This tag present each security group associated to EKS node indicates share or not."
  default     = "shared" # shared / owned
  type        = string
}
