resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = file(var.path_to_pub_key)
}

resource "aws_instance" "example" {
  ami = lookup(var.amis, var.aws_region)
  instance_type = "t2.micro"
  key_name = aws_key_pair.mykey.key_name

  provisioner "file" {
    source = "scripts.sh"
    destination = "/tmp/scripts.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/scripts.sh",
      "sudo sed -i -e 's/\r$//' /tmp/scripts.sh",
      "sudo /tmp/scripts.sh"
    ]
  }
  connection {
    type = "ssh"
    user = var.user_name
    private_key = file(var.path_to_priv_key)
    host = coalesce(self.public_ip, self.private_ip)
  }
}