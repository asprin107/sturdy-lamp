resource "aws_iam_role" "irsa_ebs_csi_driver" {
  name = "${local.naming}-irsa_ebs_csi"

  assume_role_policy = data.aws_iam_policy_document.trusted_external_secrets.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  ]

  tags = local.tags
}