########################################
# DB Subnet Group
########################################

resource "aws_db_subnet_group" "db_subnets" {
  name       = "${var.project_name}-${var.environment}-db-subnets"
  subnet_ids = var.private_database_subnet_ids

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

########################################
# PostgreSQL RDS Instance
########################################

resource "aws_db_instance" "postgres_db" {
  identifier             = "${var.project_name}-${var.environment}-db"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "15.7"
  instance_class         = "db.t3.micro"

  db_name  = var.database_name
  username = var.database_username
  password = var.database_password

  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [var.rds_security_group_id]

  multi_az            = false
  publicly_accessible = false
  skip_final_snapshot = true

  tags = {
    Name        = "${var.project_name}-postgres"
    Project     = var.project_name
    Environment = var.environment
  }
}

########################################
# SSM Parameters for Application Access
########################################

resource "aws_ssm_parameter" "db_endpoint" {
  name  = "/${var.project_name}/${var.environment}/DB_HOST"
  type  = "String"
  value = aws_db_instance.postgres_db.address

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_ssm_parameter" "db_name" {
  name  = "/${var.project_name}/${var.environment}/DB_NAME"
  type  = "String"
  value = var.database_name

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_ssm_parameter" "db_user" {
  name  = "/${var.project_name}/${var.environment}/DB_USER"
  type  = "String"
  value = var.database_username

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/${var.project_name}/${var.environment}/DB_PASSWORD"
  type  = "SecureString"
  value = var.database_password

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}