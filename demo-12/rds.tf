resource "aws_db_subnet_group" "mariadb-sub" {
  name = "mariadb-subnets"
  description = "RDS subnet group"
  subnet_ids = [aws_subnet.sub-priv-1.id, aws_subnet.sub-priv-2.id]
}

resource "aws_db_parameter_group" "rds-params" {
  name = "mariadb-parameters"
  family = "mariadb10.3"
  description = "Maria DB parameters"
  parameter {
    name = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_instance" "mariadb-int" {
  instance_class = "db.t2.micro"
  allocated_storage = 100
  engine = "mariadb"
  engine_version = "10.3.23"
  identifier = "mariadb"
  name = "mariadb"
  username = "root"
  password = var.rds-password
  db_subnet_group_name = aws_db_subnet_group.mariadb-sub.name
  parameter_group_name = aws_db_parameter_group.rds-params.name
  multi_az = false
  vpc_security_group_ids = [aws_security_group.mariadb-sg.id]
  storage_type = "gp2"
  backup_retention_period = 30
  skip_final_snapshot = true
  tags = {
    Name = "mariadb-instance"
  }
}