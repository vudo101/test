################## Launch Configuration #########################
resource "aws_launch_configuration" "launch_config" {
  name          = var.launch_config_name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  security_groups = [
#   var.default_security_group_id,
    aws_security_group.syslog_sg.id,
  ]

  iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"

  lifecycle {
    create_before_destroy = true
  }
}
/*
################## Launch Template #########################
resource "aws_launch_template" "launch_template" {
  name          = var.launch_template_name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 50
    }
  }

  vpc_security_group_ids = [
    # var.default_security_group_id,
    aws_security_group.syslog_sg.id,
  ]

  iam_instance_profile {
    name = "AmazonSSMRoleForInstancesQuickSetup"
  }
}
*/
################## Auto Scaling Group ###############################
resource "aws_autoscaling_group" "asg" {
  name                      = var.autoscaling_group_name
  launch_configuration      = aws_launch_configuration.launch_config.name
#  launch_template {
#    id      = aws_launch_template.launch_template.id
#    version = "$Latest"
#  }
  vpc_zone_identifier       = var.subnet_ids
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "Syslog-Instance"
    propagate_at_launch = true
  }
}

########### TarGet Group ###############
resource "aws_lb_target_group" "target_group" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol 
  vpc_id   = aws_vpc.syslog-vpc.id

  health_check {
    interval            = 30
    port                = 514
    protocol            = "TCP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# Attach the Target Group to the Auto Scaling Group
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn   = aws_lb_target_group.target_group.arn
}

############# Listener ################
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol 

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
