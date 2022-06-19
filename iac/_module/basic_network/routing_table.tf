### Public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}
resource "aws_default_route_table" "public" {
  default_route_table_id = aws_route_table.public.id
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

### Private
resource "aws_route_table" "private" {
  count  = length(aws_subnet.subnets_private)
  vpc_id = aws_vpc.main.id
}
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.subnets_private)
  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.subnets_private[count.index].id
}
resource "aws_route" "private_route_egress_rule" {
  count                  = length(aws_route_table.private)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[count.index % length(aws_subnet.subnets_public)].id

  depends_on = [aws_route_table.private]
}
