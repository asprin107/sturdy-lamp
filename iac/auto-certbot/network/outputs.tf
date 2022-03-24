output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "subnets_public" {
  value = aws_subnet.subnets_public
}

output "security_group" {
  value = aws_security_group.public_web
}