resource "aws_iam_role" "assume_role" {
  name                 = var.role_name
  assume_role_policy   = data.aws_iam_policy_document.iam_role_trust_relation.json
  path                 = "/users/"
  max_session_duration = 14400
  tags                 = var.tags
}

resource "aws_iam_role_policy_attachment" "assume_role_policy_att" {
  for_each   = { for k, v in var.list_role_policies : k => v }
  role       = aws_iam_role.assume_role.name
  policy_arn = each.value
}