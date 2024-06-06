output "main_vpc_id" {
  description = "VPC id."
  value       = aws_vpc.main.id
}

output "subnets_public" {
  description = "Objects associated with public subnets."
  value       = aws_subnet.subnets_public
}

output "subnets_private" {
  description = "Objects associated with private subnets."
  value       = aws_subnet.subnets_private
}

output "nat_eips" {
  description = "Objects associated with NAT Gateway's public IP."
  value       = aws_eip.nat_ip
}