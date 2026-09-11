resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    name = "${var.project_name}-igw"
  }
}

resource "aws_subnet" "web_public_sub" {
  count =  length(var.subnets.client)
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnets.client[count.index]
  map_public_ip_on_launch = true
  tags = {
     name = "${var.project_name}-web-public-${count.index + 1}-subnet"
  }
}

resource "aws_subnet" "app_pri_sub" {
  count =  length(var.subnets.server)
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnets.server[count.index]
  map_public_ip_on_launch = true
  tags = {
     name = "${var.project_name}-app-public-${count.index + 1}-subnet"
  }
}

resource "aws_subnet" "db_pri_sub" {
  count =  length(var.subnets.database)
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnets.database[count.index]
  map_public_ip_on_launch = true
  tags = {
     name = "${var.project_name}-db-private-${count.index + 1}-subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.main.id
  }
   tags ={
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route_table_association" "public-rt-asoc" {
  count =  length(aws_subnet.web_public_sub)
  subnet_id = aws_subnet.web_public_sub[count.index].id
  route_table_id = aws_route_table.public.id 
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route = {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags ={
    Name = "${var.project_name}-private-rt"
  }
}

resource "aws_route_table_association" "private-rt-asoc" {
  count =  length(aws_subnet.app_pri_sub)
  subnet_id = aws_subnet.app_pri_sub[count.index].id
  route_table_id = aws_route_table.private.id 
}

resource "aws_route_table" "db_private" {
    vpc_id = aws_vpc.main.id
    tags ={
    Name = "${var.project_name}-dbprivate-rt"
  }
}

resource "aws_route_table_association" "dbprivate-rt-asoc" {
  count =  length(aws_subnet.db_pri_sub)
  subnet_id = aws_subnet.db_pri_sub[count.index].id
  route_table_id = aws_route_table.db_private.id 
}
