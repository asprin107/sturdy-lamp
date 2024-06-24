# EKS Cluster Service Role
resource "aws_iam_role" "eks" {
  name               = "${var.name}-eks-cluster"
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
  name               = "${var.name}-eks-node"
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


# EKS IAM OIDC provider
resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.eks_certificate_authority.certificates[*].sha1_fingerprint
  url             = aws_eks_cluster.eks.identity[0].oidc[0].issuer

  tags = {
    eks_cluster_name = aws_eks_cluster.eks.name
  }
}

# See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster.html#enabling-iam-roles-for-service-accounts
# See https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate
data "tls_certificate" "eks_certificate_authority" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}