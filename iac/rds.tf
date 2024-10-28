# create database subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "database subnets"
  subnet_ids  = [aws_subnet.private_data_subnet_az1.id, aws_subnet.private_data_subnet_az2.id]
  description = "subnets for database instance"

  tags = {
    Name = "${var.project_name}-${var.environment}-database-subnets"
  }
}

# Create the RDS instance
resource "aws_db_instance" "database_instance" {
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  multi_az               = var.db_multi_az_deployment
  identifier             = var.db_instance_identifier
  username               = var.db_username
  password               = var.db_password
  db_name                = var.db_name
  instance_class         = var.db_instance_class
  allocated_storage      = 200
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  availability_zone      = var.availability_zone_2
  skip_final_snapshot    = true
  publicly_accessible    = var.publicly_accessible
}

# Calculate the RDS endpoint using a data source
data "aws_db_instance" "rds_endpoint" {
  depends_on             = [aws_db_instance.database_instance]
  db_instance_identifier = var.db_instance_identifier
}