########################################
# VPC
########################################
resource "aws_vpc" "supportdesk_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
}

########################################
# Public Subnets
########################################
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.supportdesk_vpc.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.supportdesk_vpc.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-b"
  }
}

########################################
# Private Application Subnets
########################################
resource "aws_subnet" "private_app_a" {
  vpc_id            = aws_vpc.supportdesk_vpc.id
  cidr_block        = var.private_app_subnet_a_cidr
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "${var.project_name}-${var.environment}-private-app-a"
  }
}

resource "aws_subnet" "private_app_b" {
  vpc_id            = aws_vpc.supportdesk_vpc.id
  cidr_block        = var.private_app_subnet_b_cidr
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "${var.project_name}-${var.environment}-private-app-b"
  }
}

########################################
# Private Database Subnets
########################################
resource "aws_subnet" "private_db_a" {
  vpc_id            = aws_vpc.supportdesk_vpc.id
  cidr_block        = var.private_db_subnet_a_cidr
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "${var.project_name}-${var.environment}-private-db-a"
  }
}

resource "aws_subnet" "private_db_b" {
  vpc_id            = aws_vpc.supportdesk_vpc.id
  cidr_block        = var.private_db_subnet_b_cidr
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "${var.project_name}-${var.environment}-private-db-b"
  }
}

########################################
# Internet Gateway
########################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.supportdesk_vpc.id

  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

########################################
# Public Route Table
########################################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.supportdesk_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-public-rt"
  }
}

########################################
# Associate Public Subnets with Public RT
########################################
resource "aws_route_table_association" "public_a_assoc" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b_assoc" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

########################################
# Private Route Tables (no NAT yet)
########################################
resource "aws_route_table" "private_app_rt_a" {
  vpc_id = aws_vpc.supportdesk_vpc.id

  tags = {
    Name = "${var.project_name}-${var.environment}-private-app-rt-a"
  }
}

resource "aws_route_table" "private_app_rt_b" {
  vpc_id = aws_vpc.supportdesk_vpc.id

  tags = {
    Name = "${var.project_name}-${var.environment}-private-app-rt-b"
  }
}

resource "aws_route_table_association" "private_app_a_assoc" {
  subnet_id      = aws_subnet.private_app_a.id
  route_table_id = aws_route_table.private_app_rt_a.id
}

resource "aws_route_table_association" "private_app_b_assoc" {
  subnet_id      = aws_subnet.private_app_b.id
  route_table_id = aws_route_table.private_app_rt_b.id
}

resource "aws_route_table" "private_db_rt_a" {
  vpc_id = aws_vpc.supportdesk_vpc.id

  tags = {
    Name = "${var.project_name}-${var.environment}-private-db-rt-a"
  }
}

resource "aws_route_table" "private_db_rt_b" {
  vpc_id = aws_vpc.supportdesk_vpc.id

  tags = {
    Name = "${var.project_name}-${var.environment}-private-db-rt-b"
  }
}

resource "aws_route_table_association" "private_db_a_assoc" {
  subnet_id      = aws_subnet.private_db_a.id
  route_table_id = aws_route_table.private_db_rt_a.id
}

resource "aws_route_table_association" "private_db_b_assoc" {
  subnet_id      = aws_subnet.private_db_b.id
  route_table_id = aws_route_table.private_db_rt_b.id
}