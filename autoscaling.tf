resource "aws_autoscaling_group" "web" {
 name = "WebASG"
 min_size = 2
 desired_capacity = 2
 max_size = 3

 vpc_zone_identifier = [
    aws_subnet.app_pri_sub[*].id
 ]

 target_group_arns = [ 
    aws_lb_target_group.web.arn
 ]

  health_check_type = "ELB"
  health_check_grace_period = 120

  launch_template {
    id = aws_launch_template.web.id
    version = "$Latest"
  }

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  tag {
   key      =  "Name"
   value   = "${var.project_name}WebASG"
   propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "web_target_tracking" {
  name = "${var.project_name}-WebTargetTracking"
  autoscaling_group_name = aws_autoscaling_group.web.name
  policy_type =  "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
          predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50
    disable_scale_in = false
  }
}


resource "aws_autoscaling_group" "app" {
 name = "AppASG"
 min_size = 2
 desired_capacity = 2
 max_size = 3

 vpc_zone_identifier = [
    aws_subnet.app_pri_sub[*].id
 ]

 target_group_arns = [ 
    aws_lb_target_group.web.arn
 ]

  health_check_type = "ELB"
  health_check_grace_period = 120

  launch_template {
    id = aws_launch_template.web.id
    version = "$Latest"
  }

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  tag {
   key      =  "Name"
   value   = "${var.project_name}AppASG"
   propagate_at_launch = true
  }
}


resource "aws_autoscaling_policy" "app_target_tracking" {
  name = "${var.project_name}-AppTargetTracking"
  autoscaling_group_name = aws_autoscaling_group.web.name
  policy_type =  "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
          predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50
    disable_scale_in = false
  }
}
