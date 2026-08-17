resource "aws_cloudwatch_log_group" "application_logs" {
  name              = "/aws/ec2/${var.project_name}-${var.environment}"
  retention_in_days = 7
}

resource "aws_sns_topic" "incident_alerts" {
  name = "${var.project_name}-${var.environment}-alerts"
}