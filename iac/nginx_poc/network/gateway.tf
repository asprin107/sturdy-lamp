resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-igw"
    }
  )
}

resource "aws_nat_gateway" "main" {
  count = length(aws_subnet.subnets_private)
  subnet_id = aws_subnet.subnets_private[count.index].id
  connectivity_type = "public"
  allocation_id = aws_eip.nat_ip[count.index].id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ngw"
    }
  )

  depends_on = [aws_subnet.subnets_private, aws_eip.nat_ip]
}

resource "aws_eip" "nat_ip" {
  count = length(aws_subnet.subnets_private)
  vpc = true
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-nat-eip"
    }
  )
}