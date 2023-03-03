data "aws_iam_policy_document" "trust_ec2" {
  statement {
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
  }
}