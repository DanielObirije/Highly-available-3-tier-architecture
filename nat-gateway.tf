resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-NAT-EIP"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.app_pri_sub[0].id
   tags = {
    Name = "${var.project_name}-NAT-Gateway"
  }
}