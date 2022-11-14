locals {
  eks_tags_form = {
    sbn = {
      pub = { "kubernetes.io/role/elb" = 1 }
      prv = { "kubernetes.io/role/internal-elb" = 1 }
    }
    sg = {
      "kubernetes.io/cluster/${var.eks_cluster_name}" = var.eks_node_sg_scope # shared / owned
    }
  }
}