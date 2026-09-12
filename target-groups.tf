resource "aws_lb_target_group" "web" {
  name =  "${var.project_name}-WebALBTG"
  port = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = aws_vpc.main.id

  health_check {
    enabled = true
    protocol = "HTTP"
    path = "/"
    port = "traffic-port"
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 5
    interval = 30
    matcher = "200"
  }
  tags = {
    Name = "${var.project_name}-WebALBTG"
  }
}

resource "aws_lb_target_group" "app" {
  name =  "${var.project_name}-AppTG"
  port = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = aws_vpc.main.id

  health_check {
    enabled = true
    protocol = "HTTP"
    path = "/"
    port = "traffic-port"
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 5
    interval = 30
    matcher = "200"
  }
  tags = {
    Name = "${var.project_name}-AppTG"
  }
}