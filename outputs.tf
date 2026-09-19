output "vpc_id" {
  value = aws_vpc.main.id
}

output "web_alb_dns_name" {
  description = "Public DNS name of Web ALB"

  value = aws_lb.web.dns_name
}

output "app_alb_dns_name" {
  description = "Internal DNS name of App ALB"

  value = aws_lb.app.dns_name
}

output "web_target_group_arn" {
  value = aws_lb_target_group.web.arn
}

output "app_target_group_arn" {
  value = aws_lb_target_group.app.arn
}

output "nat_gateway_public_ip" {
  value = aws_eip.nat.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.main.address
}

output "rds_port" {
  value = aws_db_instance.main.port
}