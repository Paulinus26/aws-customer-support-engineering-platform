########################################
# Application Load Balancer
########################################

resource "aws_lb" "app_alb" {
  name               = "${var.project_name}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name        = "${var.project_name}-alb"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

########################################
# Target Group
########################################

resource "aws_lb_target_group" "app_tg" {
  name     = "${var.project_name}-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    port                = "8080"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 15
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

########################################
# HTTP Listener
########################################

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

########################################
# Launch Template
########################################

resource "aws_launch_template" "app_lt" {
  name_prefix   = "${var.project_name}-lt-"
  image_id      = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_pair_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.ec2_security_group_id]
  }

  user_data = base64encode(file("${path.root}/../../scripts/setup.sh"))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.project_name}-app"
      Project     = var.project_name
      Environment = var.environment
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

########################################
# Auto Scaling Group
########################################

resource "aws_autoscaling_group" "app_asg" {
  name                = "${var.project_name}-asg"
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = [aws_lb_target_group.app_tg.arn]

  desired_capacity = 1
  min_size         = 1
  max_size         = 2

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-app"
    propagate_at_launch = true
  }
}