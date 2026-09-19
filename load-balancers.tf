resource "aws_lb" "web" {
  name = "WebALB"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.web.id ]
  subnets = aws_subnet.web_public_sub[*].id 

  tags = {
     name = "${var.project_name}-WebALB"
  }
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_lb" "app" {
  name = "AppALB"
  internal = true
  load_balancer_type = "application"
  security_groups = [aws_security_group.app.id]
  subnets = aws_subnet.app_pri_sub[*].id 

  tags = {
     name = "${var.project_name}-AppALB"
  }
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}