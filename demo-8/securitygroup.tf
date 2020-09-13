resource "aws_security_group" "allow-ssh" {
  name = "Allow-ssh"
  vpc_id = aws_vpc.main.id
  description = "SG to allow ssh and all egress"
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh"
  }
}