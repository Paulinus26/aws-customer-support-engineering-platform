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