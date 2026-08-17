###############################################################
# Root Module Outputs
###############################################################

output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.networking.public_subnet_ids
}

output "private_app_subnet_ids" {
  description = "Private application subnet IDs"
  value       = module.networking.private_app_subnet_ids
}

output "private_database_subnet_ids" {
  description = "Private database subnet IDs"
  value       = module.networking.private_database_subnet_ids
}

output "application_url" {
  description = "Application Load Balancer DNS Name"
  value       = module.compute.alb_dns_name
}