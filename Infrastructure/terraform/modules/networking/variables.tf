########################################
# General
########################################

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

########################################
# Networking CIDRs
########################################

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "Public subnet A CIDR"
  type        = string
}

variable "public_subnet_b_cidr" {
  description = "Public subnet B CIDR"
  type        = string
}

variable "private_app_subnet_a_cidr" {
  description = "Private application subnet A CIDR"
  type        = string
}

variable "private_app_subnet_b_cidr" {
  description = "Private application subnet B CIDR"
  type        = string
}

variable "private_db_subnet_a_cidr" {
  description = "Private database subnet A CIDR"
  type        = string
}

variable "private_db_subnet_b_cidr" {
  description = "Private database subnet B CIDR"
  type        = string
}