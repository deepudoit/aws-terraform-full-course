data "aws_ip_ranges" "ip-range" {
  services = ["ec2"]
  regions = ["us-east-1","us-west-2"]
}

resource "aws_security_group" "ec2-sg" {
  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = slice(data.aws_ip_ranges.ip-range.cidr_blocks, 0, 50)
  }
  tags = {
    creatDate = data.aws_ip_ranges.ip-range.create_date
    syncToken = data.aws_ip_ranges.ip-range.sync_token
  }
}