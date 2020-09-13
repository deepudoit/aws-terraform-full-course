resource "aws_instance" "example" {
  ami = lookup(var.amis, var.aws_region)
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.private_ip} >> priv_ip.txt"
  }
}

output "pub_ip" {
  value = aws_instance.example.public_ip
}