resource "aws_instance" "example" {
  ami = lookup(var.amis, var.aws_region)
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
  }
}

output "ips" {
  value = aws_instance.example.public_ip
}