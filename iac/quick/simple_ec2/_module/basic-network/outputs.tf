output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "list_public_subnet" {
  value = aws_subnet.subnets_public
}