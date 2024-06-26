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
  count                   = var.rule.subnets.pub.amount
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, var.rule.subnets.newbits, count.index)
  availability_zone       = "${var.region}${var.rule.subnets.available_zones[count.index % length(var.rule.subnets.available_zones)]}"
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  tags = merge(
    var.tags,
    {
      Name = "${var.name}-pub-${var.rule.subnets.available_zones[count.index % length(var.rule.subnets.available_zones)]}"
    },
    var.eks_enabled ? {
      "kubernetes.io/role/elb" = "1"
    } : {}
  )
}

resource "aws_subnet" "subnets_private" {
  count             = var.rule.subnets.prv.amount
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, var.rule.subnets.newbits, count.index + var.rule.subnets.pub.max)
  availability_zone = "${var.region}${var.rule.subnets.available_zones[count.index % length(var.rule.subnets.available_zones)]}"
  vpc_id            = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      Name = "${var.name}-prv-${var.rule.subnets.available_zones[count.index % length(var.rule.subnets.available_zones)]}"
    },
    var.eks_enabled ? {
      "kubernetes.io/role/internal-elb" = "1"
    } : {}
  )
}