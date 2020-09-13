resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_classiclink = false
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "main"
  }
}

#Public subnets
resource "aws_subnet" "sub-pub-1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = true
  availability_zone = "${var.aws-region}a"
  tags = {
    Name = "Public subnet 1"
  }
}

resource "aws_subnet" "sub-pub-2" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = true
  availability_zone = "${var.aws-region}b"
  tags = {
    Name = "Public subnet 2"
  }
}

resource "aws_subnet" "sub-pub-3" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = true
  availability_zone = "${var.aws-region}c"
  tags = {
    Name = "Public subnet 3"
  }
}

#Private subnets
resource "aws_subnet" "sub-priv-1" {
  cidr_block = "10.0.11.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = false
  availability_zone = "${var.aws-region}a"
  tags = {
    Name = "Private subnet 1"
  }
}

resource "aws_subnet" "sub-priv-2" {
  cidr_block = "10.0.22.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = false
  availability_zone = "${var.aws-region}b"
  tags = {
    Name = "Private subnet 2"
  }
}

resource "aws_subnet" "sub-priv-3" {
  cidr_block = "10.0.33.0/24"
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = false
  availability_zone = "${var.aws-region}c"
  tags = {
    Name = "Private subnet 3"
  }
}

#Internet gateway
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "main-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }
  tags = {
    Name = "main-pub-1"
  }
}

resource "aws_route_table_association" "pub-1" {
  route_table_id = aws_route_table.main-rt.id
  subnet_id = aws_subnet.sub-pub-1.id
}

resource "aws_route_table_association" "pub-2" {
  route_table_id = aws_route_table.main-rt.id
  subnet_id = aws_subnet.sub-pub-2.id
}

resource "aws_route_table_association" "pub-3" {
  route_table_id = aws_route_table.main-rt.id
  subnet_id = aws_subnet.sub-pub-3.id
}
