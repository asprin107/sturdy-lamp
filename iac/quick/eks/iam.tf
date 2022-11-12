resource "aws_iam_role" "eks" {
  name               = "${var.project}-${var.service}-${var.env}-eks-cluster"
  assume_role_policy = data.aws_iam_policy_document.eks-cluster.json
}

resource "aws_iam_role_policy_attachment" "cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_iam_role_policy_attachment" "cluster-vpc-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks.name
}