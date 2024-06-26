module "network" {
  source = "../../_module/network/v1-alpha"

  name   = module.naming.name
  region = var.region

  rule = {
    host_cidr = "10.0.0.0/16"
    subnets = {
      newbits         = 6
      available_zones = ["a", "c"]
      pub = {
        amount = 2
        max    = 20
      }
      prv = {
        amount = 2
        max    = 44
      }
    }
  }
}

resource "aws_security_group" "service_sg_for_eks" {
  name        = "${module.naming.name}-web-service"
  description = "Security group for argocd web server."
  vpc_id      = module.network.main_vpc_id

  tags = {
    Name = "${module.naming.name}-web-service"
  }

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

data "http" "current_ip" {
  url = "https://ipinfo.io/ip"
}