resource "aws_eks_addon" "aws_ebs_csi_driver" {
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = var.addon_version
  cluster_name             = var.eks.cluster_name
  service_account_role_arn = aws_iam_role.irsa_ebs_csi_driver.arn
}