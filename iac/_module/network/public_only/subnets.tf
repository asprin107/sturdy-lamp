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
**/

resource "aws_subnet" "subnets_public" {
  count                   = var.rule.subnets.pub.amount
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, var.rule.subnets.newbits, count.index)
  availability_zone       = "${var.region}${var.rule.subnets.available_zones[count.index % length(var.rule.subnets.available_zones)]}"
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-pub-sbn-${var.rule.subnets.available_zones[count.index % length(var.rule.subnets.available_zones)]}"
    },
    var.eks_tags != null ? var.eks_tags.sbn.pub : {}
  )
}