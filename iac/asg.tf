# create a launch template
# terraform aws launch template
resource "aws_launch_template" "webserver_launch_template" {
  name                   = var.launch_template_name
  image_id               = var.ami_id
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2_key_pair_name
  description            = "launch template for asg"
  vpc_security_group_ids = [aws_security_group.app_server_security_group.id]

  iam_instance_profile {
    name = "S3FullAccessInstanceProfile"
  }

  monitoring {
    enabled = true
  }

  user_data = base64encode(templatefile("${path.module}/install-and-configure-nest-app.sh.tpl", {
    PROJECT_NAME = var.project_name
    ENVIRONMENT  = var.environment
    RECORD_NAME  = var.record_name
    DOMAIN_NAME  = var.domain_name
    RDS_ENDPOINT = data.aws_db_instance.rds_endpoint.endpoint
    RDS_DB_NAME  = var.db_name
    USERNAME     = var.db_username
    PASSWORD     = var.db_password
  }))
}

# create auto scaling group
# terraform aws autoscaling group
resource "aws_autoscaling_group" "auto_scaling_group" {
  vpc_zone_identifier = [aws_subnet.private_app_subnet_az1.id, aws_subnet.private_app_subnet_az2.id]
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  name                = "dev-asg"
  health_check_type   = "ELB"

  launch_template {
    name    = aws_launch_template.webserver_launch_template.name
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg-webserver"
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes        = [target_group_arns]
    create_before_destroy = true
  }
  depends_on = [aws_instance.data_migrate_ec2]
}

# attach auto scaling group to alb target group
# terraform aws autoscaling attachment
resource "aws_autoscaling_attachment" "asg_alb_target_group_attachment" {
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.id
  lb_target_group_arn    = aws_lb_target_group.alb_target_group.arn
}

# create an auto scaling group notification
# terraform aws autoscaling notification
resource "aws_autoscaling_notification" "webserver_asg_notifications" {
  group_names = [aws_autoscaling_group.auto_scaling_group.name]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.user_updates.arn
} 