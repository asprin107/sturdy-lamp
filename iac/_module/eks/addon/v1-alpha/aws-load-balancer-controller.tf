module "irsa-aws_load_balancer_controller" {
  count  = var.aws_load_balancer_controller-enabled ? 1 : 0
  source = "../../../iam/irsa/aws-load-balancer-controller"

  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_issuer_url
  suffix                = var.name
}

variable "aws_load_balancer_controller-enabled" {
  type    = bool
  default = true
}