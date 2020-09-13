resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_classiclink = false
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
  tags = {
    Name = "Main VPC"
  }
}

#Public subnets
resource "aws_subnet" "pub-sub1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = true
  availability_zone = "${var.aws-region}a"
  tags = {
    Name = "Public Sub 1"
  }
}

resource "aws_subnet" "pub-sub2" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = true
  availability_zone = "${var.aws-region}b"
  tags = {
    Name = "Public Sub 2"
  }
}

resource "aws_subnet" "pub-sub3" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = true
  availability_zone = "${var.aws-region}c"
  tags = {
    Name = "Public Sub 3"
  }
}

#Private subnets
resource "aws_subnet" "priv-sub1" {
  cidr_block = "10.0.11.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = false
  availability_zone = "${var.aws-region}a"
  tags = {
    Name = "Private Sub 1"
  }
}

resource "aws_subnet" "priv-sub2" {
  cidr_block = "10.0.22.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = false
  availability_zone = "${var.aws-region}b"
  tags = {
    Name = "Private Sub 2"
  }
}

resource "aws_subnet" "priv-sub3" {
  cidr_block = "10.0.33.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = false
  availability_zone = "${var.aws-region}c"
  tags = {
    Name = "Private Sub 3"
  }
}

#Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "main-pub" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "main-pub-1"
  }
}

resource "aws_route_table_association" "main-pub-1" {
  route_table_id = aws_route_table.main-pub.id
  subnet_id = aws_subnet.pub-sub1.id
}

resource "aws_route_table_association" "main-pub-2" {
  route_table_id = aws_route_table.main-pub.id
  subnet_id = aws_subnet.pub-sub2.id
}

resource "aws_route_table_association" "main-pub-3" {
  route_table_id = aws_route_table.main-pub.id
  subnet_id = aws_subnet.pub-sub3.id
}