# Terraform Remote State
##################################################

# This backend will be enabled after the S3 state bucket
# and DynamoDB lock table are created.

# terraform {
#   backend "s3" {
#     bucket         = "supportdesk-terraform-state"
#     key            = "dev/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     use_lockfile   = true
#   }
# }