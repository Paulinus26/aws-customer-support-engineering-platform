output "log_group_name" {
  description = "CloudWatch log group name"
  value       = aws_cloudwatch_log_group.application_logs.name
}

output "sns_topic_arn" {
  description = "SNS topic ARN for incident alerts"
  value       = aws_sns_topic.incident_alerts.arn
}