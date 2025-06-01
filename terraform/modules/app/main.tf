// modules/app/main.tf

# Create an Application Load Balancer (ALB)
resource "aws_lb" "app_alb" {
  name               = "${var.alb_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.app_sg_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = var.alb_name
  }
}

# ALB Target Group
resource "aws_lb_target_group" "app_tg" {
  name     = "${var.alb_name}-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Name = "${var.alb_name}-tg"
  }
}

# ALB Listener
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

# Launch Template for ASG
resource "aws_launch_template" "app_lt" {
  name_prefix   = "${var.app_name_prefix}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.app_sg_id]
  }

  user_data = base64encode(templatefile("${path.module}/user_data.tpl", {
    app_port = var.app_port
    # Any other variables you need in user_data
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.app_name_prefix}-instance"
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "app_asg" {
  name                      = "${var.app_name_prefix}-asg"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_capacity
  vpc_zone_identifier       = var.public_subnet_ids
  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.app_tg.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 60

  tags = [
    for key, value in var.asg_tags : {
      key                 = key
      value               = value
      propagate_at_launch = true
    }
  ]
}
