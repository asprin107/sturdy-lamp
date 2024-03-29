/**
network:
  subnets:
    newbits : 6
    available_zones :
      - a
      - c
    pub :
      amount : 2
      max : 20
    prv :
      amount : 4
      max : 44
**/

resource "aws_subnet" "subnets_public" {
  count             = var.rule.network.subnets.pub.amount
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, var.rule.network.subnets.newbits, count.index)
  availability_zone = "${var.region}${var.rule.network.subnets.available_zones[count.index % length(var.rule.network.subnets.available_zones)]}"
  vpc_id            = aws_vpc.main.id
  tags = merge(
    {
      Name = "${var.project_name}-pub-sbn-${var.rule.network.subnets.available_zones[count.index % length(var.rule.network.subnets.available_zones)]}"
    }
  )
}