resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.pub-sub1.id
  depends_on = [aws_internet_gateway.main-gw]
}

resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "main-private-1"
  }
}

resource "aws_route_table_association" "main-priv-1" {
  route_table_id = aws_route_table.main-private.id
  subnet_id = aws_subnet.priv-sub1.id
}

resource "aws_route_table_association" "main-priv-2" {
  route_table_id = aws_route_table.main-private.id
  subnet_id = aws_subnet.priv-sub2.id
}

resource "aws_route_table_association" "main-priv-3" {
  route_table_id = aws_route_table.main-private.id
  subnet_id = aws_subnet.priv-sub3.id
}