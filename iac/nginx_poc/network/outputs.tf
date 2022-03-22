output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "subnets_public" {
  value = aws_subnet.subnets_public
}

output "subnets_private" {
  value = aws_subnet.subnets_private
}