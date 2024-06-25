output "role_name" {
  value = aws_iam_role.irsa_role.name
}

output "role_arn" {
  value = aws_iam_role.irsa_role.arn
}