# EKS IRSA for kyverno
module "irsa_role" {
  source = "../irsa-role"

  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  eks_oidc_provider_url = var.eks_oidc_provider_url
  suffix                = "kyverno-${var.suffix}"

  k8s_namespace                   = var.k8s_namespace
  k8s_service_account_name_prefix = var.k8s_service_account_name_prefix
}

resource "aws_iam_role_policy_attachment" "irsa-att-ecr" {
  policy_arn = data.aws_iam_policy.ecr_readonly.arn
  role       = module.irsa_role.role_name
}

resource "aws_iam_role_policy_attachment" "irsa-att-signer" {
  policy_arn = aws_iam_policy.irsa-kyverno.arn
  role       = module.irsa_role.role_name
}

data "aws_iam_policy" "ecr_readonly" {
  name = "AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_policy" "irsa-kyverno" {
  name   = "eks-irsa-kyverno-${var.suffix}"
  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "signer:GetSigningProfile",
                "signer:ListSigningProfiles",
                "signer:SignPayload",
                "signer:GetRevocationStatus",
                "signer:DescribeSigningJob",
                "signer:ListSigningJobs"
            ],
            "Resource": "*"
        }
    ]
}
EOT
}