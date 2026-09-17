resource "aws_autoscaling_group" "web" {
 name = "WebASG"
 min_size = 2
 desired_capacity = 2
 max_size = 3
 vpc_zone_identifier = [
    aws_subnet.app_pri_sub[*].id
 ]
  
}