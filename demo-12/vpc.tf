resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_classiclink = false
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "Main VPC"
  }
}

resource "aws_subnet" "sub-pub-1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.main.id
  availability_zone = "${var.aws-region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "sub-priv-1" {
  cidr_block = "10.0.11.0/24"
  vpc_id = aws_vpc.main.id
  availability_zone = "${var.aws-region}b"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private subnet 1"
  }
}

resource "aws_subnet" "sub-priv-2" {
  cidr_block = "10.0.22.0/24"
  vpc_id = aws_vpc.main.id
  availability_zone = "${var.aws-region}c"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private subnet 2"
  }
}

resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main public igw"
  }
}

resource "aws_route_table" "main-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }
  tags = {
    Name = "Main public route"
  }
}

resource "aws_route_table_association" "igw-rt-assc" {
  route_table_id = aws_route_table.main-rt.id
  subnet_id = aws_subnet.sub-pub-1.id
}