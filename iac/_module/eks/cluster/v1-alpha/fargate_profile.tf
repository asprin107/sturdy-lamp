resource "aws_eks_fargate_profile" "fargate" {
  cluster_name           = aws_eks_cluster.eks.name
  fargate_profile_name   = "eks-fargate-${var.name}"
  pod_execution_role_arn = aws_iam_role.fargate.arn
  subnet_ids             = var.eks_subnet_ids

  selector {
    namespace = "fargate"
  }
}

resource "aws_iam_role" "fargate" {
  name               = "eks-irsa-fargate_profile-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.trust-fargate.json
}

data "aws_iam_policy_document" "trust-fargate" {
  version = "2012-10-17"
  statement {
    principals {
      type = "Service"
      identifiers = [
        "eks-fargate-pods.amazonaws.com"
      ]
    }
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    condition {
      test     = "ArnLike"
      values   = ["arn:aws:eks:region-code:${data.aws_caller_identity.current.account_id}:fargateprofile/${aws_eks_cluster.eks.name}/*"]
      variable = "aws:SourceArn"
    }
  }
}

resource "aws_iam_role_policy_attachment" "fargate-policy" {
  role       = aws_iam_role.fargate.name
  policy_arn = data.aws_iam_policy.fargate.arn
}

data "aws_iam_policy" "fargate" {
  name = "AmazonEKSFargatePodExecutionRolePolicy"
}