output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "pub_subnet_ids" {
  value = [for v in aws_subnet.subnets_public : v.id]
}