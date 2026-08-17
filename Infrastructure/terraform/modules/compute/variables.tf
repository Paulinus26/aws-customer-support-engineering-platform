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

########################################
# Networking
########################################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private application subnet IDs"
  type        = list(string)
}

########################################
# Security
########################################

variable "alb_security_group_id" {
  description = "ALB security group ID"
  type        = string
}

variable "ec2_security_group_id" {
  description = "EC2 security group ID"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name"
  type        = string
}

########################################
# Database
########################################

variable "database_endpoint" {
  description = "RDS endpoint"
  type        = string
}

########################################
# Compute
########################################

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "key_pair_name" {
  description = "EC2 key pair name"
  type        = string
}