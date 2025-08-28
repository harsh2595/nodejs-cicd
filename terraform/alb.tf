# Application Load Balancer
resource "aws_lb" "alb" {
  name               = "nodejs-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public.id]
}

# Target Group (Blue)
resource "aws_lb_target_group" "blue" {
  name     = "blue-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type = "ip"
}

# ALB Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}

