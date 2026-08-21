terraform {
  backend "s3" {
    bucket       = "supportdesk-terraform-state-963108102569"
    key          = "supportdesk/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}