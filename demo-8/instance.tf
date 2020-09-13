resource "aws_instance" "example" {
  ami = lookup(var.amis, var.aws-region)
  instance_type = "t2.micro"
  key_name = aws_key_pair.mykey.key_name
  subnet_id = aws_subnet.sub-pub-1.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  tags = {
    Name = "EC2 Sample with SSH"
  }
}