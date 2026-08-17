###############################################################
# Root Terraform Configuration
# SupportDesk AWS Customer Support Engineering Platform

# Networking

module "networking" {
  source = "./modules/networking"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  vpc_cidr                  = var.vpc_cidr
  public_subnet_a_cidr      = var.public_subnet_a_cidr
  public_subnet_b_cidr      = var.public_subnet_b_cidr
  private_app_subnet_a_cidr = var.private_app_subnet_a_cidr
  private_app_subnet_b_cidr = var.private_app_subnet_b_cidr
  private_db_subnet_a_cidr  = var.private_db_subnet_a_cidr
  private_db_subnet_b_cidr  = var.private_db_subnet_b_cidr
}

###############################################################
# Security
###############################################################

module "security" {
  source = "./modules/security"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.networking.vpc_id
}

###############################################################
# Database
###############################################################

module "database" {
  source = "./modules/database"

  project_name = var.project_name
  environment  = var.environment

  private_database_subnet_ids = module.networking.private_database_subnet_ids

  rds_security_group_id = module.security.rds_security_group_id

  database_name     = var.database_name
  database_username = var.database_username
  database_password = var.database_password
}

###############################################################
# Storage
###############################################################

module "storage" {
  source = "./modules/storage"

  project_name = var.project_name
  environment  = var.environment
}

###############################################################
# Compute
###############################################################

module "compute" {
  source = "./modules/compute"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.networking.vpc_id

  public_subnet_ids = module.networking.public_subnet_ids

  private_subnet_ids = module.networking.private_app_subnet_ids

  alb_security_group_id = module.security.alb_security_group_id

  ec2_security_group_id = module.security.ec2_security_group_id

  instance_profile_name = module.security.ec2_instance_profile_name

  database_endpoint = module.database.db_endpoint

  ami_id        = var.ami_id
  key_pair_name = var.key_pair_name
}

###############################################################
# Monitoring
###############################################################

module "monitoring" {
  source = "./modules/monitoring"

  project_name = var.project_name
  environment  = var.environment

  autoscaling_group_name = module.compute.autoscaling_group_name

  alb_arn_suffix = module.compute.alb_arn_suffix
}