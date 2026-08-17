resource "aws_s3_bucket" "logs_bucket" {
  bucket = "${var.project_name}-${var.environment}-logs-bucket"
}

resource "aws_backup_vault" "backup_vault" {
  name = "${var.project_name}-${var.environment}-backup-vault"
}