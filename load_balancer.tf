resource "aws_lb" "wordpress_lb" {
  name               = "wordpress-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer-sg.id]
  subnets            = [for subnet in data.aws_subnet.main : subnet.id]


  enable_deletion_protection = false

  tags = {
    Environment = "wordpress__lb"
  }
}

resource "aws_lb_listener" "http-wordpress" {
  load_balancer_arn = aws_lb.wordpress_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.wordpress_tg.arn
      }
      stickiness {
        enabled  = true
        duration = 28800
      }
    }
  }
}
