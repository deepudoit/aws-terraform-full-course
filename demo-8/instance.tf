resource "aws_instance" "example" {
  ami                    = var.amis[var.aws-region]
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.mykey.key_name
  subnet_id              = aws_subnet.sub-pub-1.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  tags = {
    Name = "EC2 Sample with SSH"
  }
}

resource "aws_ebs_volume" "ebs-vol-1" {
  availability_zone = "${var.aws-region}a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "Addntl vol"
  }
}

resource "aws_volume_attachment" "ebs-vol-attch" {
  device_name = "/dev/xvdh"
  instance_id = aws_instance.example.id
  volume_id   = aws_ebs_volume.ebs-vol-1.id
}