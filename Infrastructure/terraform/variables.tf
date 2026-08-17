variable "project_name" {
  type    = string
  default = "supportdesk"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "private_app_subnet_a_cidr" {
  type    = string
  default = "10.0.11.0/24"
}

variable "private_app_subnet_b_cidr" {
  type    = string
  default = "10.0.12.0/24"
}

variable "private_db_subnet_a_cidr" {
  type    = string
  default = "10.0.21.0/24"
}

variable "private_db_subnet_b_cidr" {
  type    = string
  default = "10.0.22.0/24"
}

variable "database_name" {
  type    = string
  default = "supportdesk"
}

variable "database_username" {
  type    = string
  default = "postgres"
}

variable "database_password" {
  type      = string
  sensitive = true
}

variable "ami_id" {
  type = string
}

variable "key_pair_name" {
  type = string
}
 