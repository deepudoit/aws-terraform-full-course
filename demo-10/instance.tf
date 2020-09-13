resource "aws_instance" "example" {
  ami           = var.amis[var.aws-region]
  instance_type = "t2.micro"

  key_name = aws_key_pair.mykey.key_name

  vpc_security_group_ids = [aws_security_group.main-sg.id]

  subnet_id = aws_subnet.main-pub-1.id

  user_data = data.template_cloudinit_config.cloudinit-example.rendered
}

resource "aws_ebs_volume" "ec2-ebs" {
  availability_zone = "${var.aws-region}a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "Extra Volume"
  }
}

resource "aws_volume_attachment" "ebs-vol-attach" {
  device_name  = var.instance-device-name
  instance_id  = aws_instance.example.id
  volume_id    = aws_ebs_volume.ec2-ebs.id
  skip_destroy = true
}


