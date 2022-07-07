data "aws_iam_policy_document" "lambda_svc_policy" {
  statement {

  }
}

data "aws_subnet" "lambda_subnet" {
  filter {
    name   = ""
    values = []
  }
}

data "aws_security_groups" "lambda_security_group" {
  filter {
    name   = ""
    values = []
  }
}