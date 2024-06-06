module "eks" {
  source = "../../_module/eks/cluster/v1-alpha"

  name = module.naming.name

  eks_subnet_ids                = module.network.public_subnet_ids
  eks_security_group_ids        = []
  eks_nodegroup_capacity_type   = "ON_DEMAND"
  eks_nodegroup_ami_type        = "AL2_x86_64"
  eks_nodegroup_instance_types  = ["t3.medium"]
  eks_nodegroup_disk_size       = 200
  eks_nodegroup_desired_size    = 3
  eks_nodegroup_max_size        = 4
  eks_nodegroup_min_size        = 0
  eks_nodegroup_max_unavailable = 1
}