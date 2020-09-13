variable "aws_region" {
  default = "us-east-1"
}

variable "amis" {
  type = map(string)
  default = {
    us-east-1 = "ami-0817d428a6fb68645"
    us-west-1 = "ami-03fac5402e10ea93b"
    us-east-2 = "ami-0e82959d4ed12de3f"
  }
}