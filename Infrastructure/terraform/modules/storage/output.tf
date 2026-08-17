output "logs_bucket_name" {
  description = "Logs bucket name"
  value       = aws_s3_bucket.logs_bucket.id
}

output "logs_bucket_arn" {
  description = "Logs bucket ARN"
  value       = aws_s3_bucket.logs_bucket.arn
}

output "backup_vault_name" {
  description = "Backup vault name"
  value       = aws_backup_vault.backup_vault.name
}