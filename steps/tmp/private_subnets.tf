resource "aws_subnet" "private" {
  count                   = var.AZCount

  vpc_id                  = aws_vpc.this.id
  availability_zone       = data.aws_availability_zones.available_azs.names[count.index]
  cidr_block              = var.privateSubnetCidrs[count.index]
  tags                    = {
    Name = "private-subnet${count.index}-${var.environmentName}"
  }
}

resource "aws_route_table" "private" {
  count  = var.createNATGateways ? var.AZCount : 0
  
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }
  tags = {
    Name = "nat-gateway-route-table-${count.index}-${var.environmentName}"
  }
}

resource "aws_route_table_association" "private_subnet_routes" {
  count          = var.createNATGateways ? var.AZCount : 0
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}