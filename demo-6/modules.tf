module "consul" {
  source = "github.com/wardviaene/terraform-consul-module.git?ref=terraform-0.12"
  vpc_id = aws_default_vpc.default.id
  region = var.aws-region
  key_name = aws_key_pair.mykey.key_name
  key_path = var.path-to-priv-key
  subnets = {
    "0" = aws_default_subnet.default_az1.id
    "1" = aws_default_subnet.default_az2.id
    "2" = aws_default_subnet.default_az3.id
  }
}

output "consul-output" {
  value = module.consul.server_address
}