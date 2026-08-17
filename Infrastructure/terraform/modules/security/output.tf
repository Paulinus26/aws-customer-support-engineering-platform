output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}

output "ec2_security_group_id" {
  value = aws_security_group.ec2_sg.id
}

output "rds_security_group_id" {
  value = aws_security_group.rds_sg.id
}

output "ec2_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}