resource "helm_release" "aws_load_balancer_controller" {
  count            = var.aws_load_balancer_controller-enabled ? 1 : 0
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  name             = "aws-load-balancer-controller"
  namespace        = var.aws_load_balancer_controller-namespace
  create_namespace = true

  version = var.aws_load_balancer_controller-version

  values = var.aws_load_balancer_controller-values == null ? [templatefile("${path.module}/values/aws_load_balancer_controller-values.yaml", {
    cluster_name = var.name
    region       = data.aws_region.current.name
    vpc_id       = var.vpc_id
    sa_role_arn  = module.irsa-aws_load_balancer_controller[0].irsa-role-arn
  })] : var.aws_load_balancer_controller-values
}

module "irsa-aws_load_balancer_controller" {
  count  = var.aws_load_balancer_controller-irsa_need ? 1 : 0
  source = "../../../iam/irsa/aws-load-balancer-controller"

  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_issuer_url
  suffix                = var.name
  k8s_namespace         = var.aws_load_balancer_controller-namespace
}

variable "aws_load_balancer_controller-enabled" {
  type    = bool
  default = false
}

variable "aws_load_balancer_controller-irsa_need" {
  type    = bool
  default = true
}

variable "aws_load_balancer_controller-namespace" {
  type    = string
  default = "kube-system"
}

variable "aws_load_balancer_controller-version" {
  type    = string
  default = "1.8.1"
}

variable "aws_load_balancer_controller-values" {
  type    = list(string)
  default = null
}