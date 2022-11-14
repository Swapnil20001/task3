resource "aws_launch_template" "wordpress" {
  name_prefix   = "wordpress-template"
  image_id      = aws_ami_from_instance.wordpress.id
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "wordpress-asg" {
  availability_zones        = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[2]]
  desired_capacity          = 1
  max_size                  = 3
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true

  launch_template {
    id      = aws_launch_template.wordpress.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.wordpress-asg.id
  lb_target_group_arn    = aws_lb_target_group.wordpress_tg.arn
}