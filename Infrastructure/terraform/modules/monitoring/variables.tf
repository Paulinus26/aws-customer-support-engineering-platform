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
# Monitoring Targets
########################################

variable "autoscaling_group_name" {
  description = "Auto Scaling Group name"
  type        = string
}

variable "alb_arn_suffix" {
  description = "ALB ARN suffix for CloudWatch alarms"
  type        = string
}