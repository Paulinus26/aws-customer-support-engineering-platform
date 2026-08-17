output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.app_alb.dns_name
}

output "alb_arn_suffix" {
  description = "ALB ARN suffix"
  value       = aws_lb.app_alb.arn_suffix
}

output "autoscaling_group_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.app_asg.name
}