# EKS Cluster Service Role
resource "aws_iam_role" "eks" {
  name               = "${var.project}-${var.service}-${var.env}-eks-cluster"
  assume_role_policy = data.aws_iam_policy_document.trust-eks-cluster.json
}

resource "aws_iam_role_policy_attachment" "cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_iam_role_policy_attachment" "cluster-vpc-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks.name
}


# EKS Node Service Role
resource "aws_iam_role" "eks_node" {
  name               = "${var.project}-${var.service}-${var.env}-eks-node"
  assume_role_policy = data.aws_iam_policy_document.trust-eks-node.json
}

resource "aws_iam_role_policy_attachment" "eks-node-basic-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "eks-node-cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "eks-node-ecr-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node.name
}


# EKS IRSA for aws-loadbalancer-controller
resource "aws_iam_policy" "irsa-loadbalancer-controller" {
  name   = "${var.project}-${var.service}-${var.env}-eks-irsa-loadbalancer-controller"
  policy = file("../../_resources/lamp-bmt/policy-irsa-loadbalancer-controller.json")
}

# EKS IRSA for cluster-autoscaler
resource "aws_iam_policy" "irsa-cluster-autoscaler" {
  name   = "${var.project}-${var.service}-${var.env}-eks-irsa-cluster-autoscaler"
  policy = data.aws_iam_policy_document.irsa-cluster-autoscaler.json
}