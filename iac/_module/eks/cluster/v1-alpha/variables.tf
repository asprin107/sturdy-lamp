variable "name" {
  description = "This used for all resource names."
  type        = string
}

variable "eks_version" {
  description = "Version of EKS Cluster."
  type        = string
  default     = "1.28"
}
variable "eks_subnet_ids" {
  description = "EKS subnet ids cluster deployed."
  type        = set(string)
}
variable "eks_security_group_ids" {
  description = "EKS cluster security group ids."
  type        = set(string)
}

variable "eks_nodegroup_capacity_type" {
  description = "ON_DEMAND | SPOT"
  type        = string
}
variable "eks_nodegroup_ami_type" {
  description = "EKS default nodegroup AMI type. See https://docs.aws.amazon.com/eks/latest/APIReference/API_Nodegroup.html#AmazonEKS-Type-Nodegroup-amiType"
  type        = string
  default     = "AL2_x86_64"
}
variable "eks_nodegroup_instance_types" {
  description = "EKS default nodegroup instance type."
  type        = set(string)
}
variable "eks_nodegroup_disk_size" {
  description = "EKS default nodegroup disk_size."
  type        = string
}
variable "eks_nodegroup_desired_size" {
  description = "EKS default nodegroup desired_size."
  type        = string
}
variable "eks_nodegroup_max_size" {
  description = "EKS default nodegroup max_size."
  type        = string
}
variable "eks_nodegroup_min_size" {
  description = "EKS default nodegroup min_size."
  type        = string
}
variable "eks_nodegroup_max_unavailable" {
  description = "EKS default nodegroup max_unavailable."
  type        = string
}

variable "tags" {
  description = "Additional tags"
  type        = map(any)
  default     = {}
}