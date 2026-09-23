resource "aws_security_group" "web" {
    name = "WebPubSG"
    description = "Security group for Web tier"
    vpc_id =  aws_vpc.main.id

   ingress{
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags ={
    Name = "${var.project_name}-WebPubSG"
  }
}


resource "aws_security_group" "app" {
  name = "AppPriSG"
  description = "Security group for Application tier"
  vpc_id =  aws_vpc.main.id

  ingress {
    description = "HTTP from Web tier"
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = [
        aws_security_group.web.id
    ]
  }

  ingress {
    description = "SSH from Web tier"
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    security_groups = [
        aws_security_group.web.id
    ]
  }
 
 ingress {
    description = "ICMP from Web tier"
    from_port = -1
    to_port   = -1
    protocol  = "icmp"

    security_groups = [
        aws_security_group.web.id
    ]
  }
  
 egress {
    description = "Internet through NAT"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
 tags ={
    Name = "${var.project_name}-AppPriSG"
  }
}

resource "aws_security_group" "db" {
  name = "DBPriSG"
  description = "Security group for RDS"
  vpc_id =  aws_vpc.main.id

  ingress {
    description = "MySQL from Application tier"
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    security_groups = [
        aws_security_group.app.id
    ]
  }

 egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
 tags ={
    Name = "${var.project_name}-DBPriSG"
  }
}