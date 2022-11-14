resource "aws_lb_target_group" "wordpress_tg" {
  name     = "tf-wordpress-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_subnet_ids.example.id
  health_check {
    healthy_threshold   = var.health_check["healthy_threshold"]
    interval            = var.health_check["interval"]
    unhealthy_threshold = var.health_check["unhealthy_threshold"]
    timeout             = var.health_check["timeout"]
    path                = var.health_check["path"]
    port                = var.health_check["port"]
  }
}

resource "aws_lb_target_group_attachment" "test2" {
  target_group_arn = aws_lb_target_group.wordpress_tg.arn
  target_id        = aws_instance.wordpress.id
  port             = 80
}