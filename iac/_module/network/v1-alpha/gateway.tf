resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    { Name = var.name }
  )
}

resource "aws_nat_gateway" "main" {
  count             = var.rule.subnets.prv.amount != 0 ? length(aws_subnet.subnets_public) : 0
  subnet_id         = aws_subnet.subnets_public[count.index].id
  connectivity_type = "public"
  allocation_id     = aws_eip.nat_ip[count.index].id

  tags = merge(
    var.tags,
    { Name = var.name }
  )

  depends_on = [aws_subnet.subnets_public, aws_eip.nat_ip]
}

resource "aws_eip" "nat_ip" {
  count = var.rule.subnets.prv.amount != 0 ? length(aws_subnet.subnets_public) : 0
  tags = merge(
    var.tags,
    { Name = var.name }
  )
}