# EKS Cluster Service Role
resource "aws_iam_role" "eks" {
  name               = "${local.naming}-eks-cluster"
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
  name               = "${local.naming}-eks-node"
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


# EKS IRSA for aws-load-balancer-controller
module "irsa-aws-load-balancer-controller" {
  source = "../../iam/irsa/aws-load-balancer-controller"
  prefix = local.naming
}

# EKS IRSA for cluster-autoscaler
module "irsa-cluster-autoscaler" {
  source   = "../../iam/irsa/cluster-autoscaler"
  eks_name = aws_eks_cluster.eks.name
  prefix   = local.naming
}