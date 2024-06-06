output "main_vpc_id" {
  description = "VPC id."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet ids list."
  value       = [for v in aws_subnet.subnets_public : v.id]
}

output "private_subnet_ids" {
  description = "Private subnet ids list."
  value       = [for v in aws_subnet.subnets_private : v.id]
}

output "nat_eips" {
  description = "Objects associated with NAT Gateway's public IP."
  value       = aws_eip.nat_ip
}