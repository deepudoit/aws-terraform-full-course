  resource "aws_security_group" "allow-ssh" {
    vpc_id = aws_vpc.main.id
    name = "allow-ssh"
    description = "Allow SSH to EC2 server"
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
      Name = "example-instance"
    }
  }

  resource "aws_security_group" "mariadb-sg" {
    vpc_id = aws_vpc.main.id
    name = "mariadb-sg"
    description = "Database security group to allow traffic from EC2"
    ingress {
      from_port = 3306
      protocol = "tcp"
      to_port = 3306
      security_groups = [aws_security_group.allow-ssh.id]
    }
    egress {
      from_port = 0
      protocol = "-1"
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
      self = true
    }
    tags = {
      Name = "Allow mariadb"
    }
  }

