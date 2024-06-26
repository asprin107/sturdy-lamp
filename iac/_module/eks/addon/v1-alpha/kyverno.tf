resource "helm_release" "kyverno" {
  count            = var.kyverno-enabled ? 1 : 0
  repository       = "https://aws.github.io/eks-charts"
  chart            = "kyverno"
  name             = "kyverno"
  namespace        = var.kyverno-namespace
  create_namespace = true
  version          = var.kyverno-version

  values = var.kyverno-values == null ? [templatefile("${path.module}/values/kyverno-values.yaml", {
    sa_role_arn = module.irsa-kyverno[0].irsa-role-arn
  })] : var.kyverno-values
}

module "irsa-kyverno" {
  count  = var.kyverno-irsa_need ? 1 : 0
  source = "../../../iam/irsa/kyverno"

  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_issuer_url
  suffix                = var.name
  k8s_namespace         = var.kyverno-namespace
}

variable "kyverno-enabled" {
  type    = bool
  default = false
}

variable "kyverno-irsa_need" {
  type    = bool
  default = true
}

variable "kyverno-namespace" {
  type    = string
  default = "kyverno"
}

variable "kyverno-version" {
  type    = string
  default = "3.2.5"
}

variable "kyverno-values" {
  type    = list(string)
  default = null
}