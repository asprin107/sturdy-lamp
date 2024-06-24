resource "helm_release" "argocd" {
  count            = var.argocd-enabled ? 1 : 0
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  version = var.argocd-version

  values = var.argocd-values

  dynamic "set" {
    for_each = local.check_service_type
    content {
      name  = set.key
      value = set.value
    }
  }
}

resource "aws_security_group" "argocd" {
  count       = var.argocd-enabled ? 1 : 0
  name        = "${var.name}-argocd"
  description = "Security group for argocd web server."
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-argocd"
    }
  )

  ingress {
    description = "HTTPS for argocd"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["${chomp(data.http.current_ip.response_body)}/32"]
  }
  ingress {
    description = "HTTP for argocd"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["${chomp(data.http.current_ip.response_body)}/32"]
  }
  egress {
    description = "Egress to all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "argocd-enabled" {
  type    = bool
  default = true
}

variable "argocd-version" {
  type    = string
  default = "6.7.18"
}

variable "argocd-type" {
  type    = string // simple / custom
  default = "simple"
}

variable "argocd-values" {
  type    = list(string)
  default = []
}

locals {
  check_service_type = var.argocd-enabled && var.argocd-type == "simple" ? {
    "server.service.type"                                                        = "LoadBalancer",
    "server.service.annotations.alb\\.ingress\\.kubernetes\\.io/security-groups" = aws_security_group.argocd[0].name
    "server.service.annotations.alb\\.ingress\\.kubernetes\\.io/manage-backend-security-group-rules" : "true"
  } : {}
}