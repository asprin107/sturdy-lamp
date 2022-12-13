module "default_tags" {
  source = "../../../_module/tags"

  aws_account = var.aws_account
  env         = var.env
  project     = var.project
  service     = var.service
}

module "eks_tags" {
  source = "../../../_module/tags/eks"

  eks_cluster_name  = "lamp-eks-test"
  eks_node_sg_scope = "shared"
}