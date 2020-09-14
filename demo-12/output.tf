output "ex-instance" {
  value = aws_instance.example.public_ip
}

output "rds-endpoint" {
  value = aws_db_instance.mariadb-int.endpoint
}