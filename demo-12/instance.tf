resource "aws_instance" "example" {
  ami = var.amis[var.aws-region]
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sub-pub-1.id
  security_groups = [aws_security_group.allow-ssh.id]
  key_name = aws_key_pair.mykey.key_name
  tags = {
    Name = "Main web server"
  }
}