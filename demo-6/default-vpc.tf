resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "${var.aws-region}a"
  tags = {
    Name = "Default subnet for ${var.aws-region}a"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "${var.aws-region}b"
  tags = {
    Name = "Default subnet for ${var.aws-region}b"
  }
}

resource "aws_default_subnet" "default_az3" {
  availability_zone = "${var.aws-region}c"
  tags = {
    Name = "Default subnet for ${var.aws-region}c"
  }
}