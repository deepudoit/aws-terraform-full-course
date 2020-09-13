resource "aws_key_pair" "mykey" {
  public_key = file(var.path-to-pub-key)
  key_name   = "mykey"
}