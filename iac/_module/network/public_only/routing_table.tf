### Public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      Name = "rt-${var.project_name}"
    }
  )
}
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.subnets_public)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.subnets_public[count.index].id
}
resource "aws_route" "public_route_egress_rule" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id

  depends_on = [aws_route_table.public]
}
