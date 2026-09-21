resource "aws_launch_template" "web" {
    name = "${var.project_name}-WebLT"
    description = "Web tier launch template"
    image_id =  data.aws_ami.ubuntu.id

    instance_type = var.instance_type
    vpc_security_group_ids = [ aws_security_group.web.id ]
    network_interfaces {
      associate_carrier_ip_address = true
      security_groups = [aws_security_group.web.id]
    }

    tag_specifications {
      resource_type = "instance"
       tags = {
          Name = "WebServer"
          Tier = "Web"
        }
    }

    lifecycle {
      create_before_destroy = true
    }

    user_data = base64encode(
        <<-EOF
            #!/bin/bash

            apt-get update -y
            apt-get install -y apache2 curl

            systemctl enable apache2
            systemctl start apache2

            TOKEN=$(curl -X PUT -s \
                -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" \
                http://169.254.169.254/latest/api/token)

            EC2AZ=$(curl -s \
                -H "X-aws-ec2-metadata-token: $TOKEN" \
                http://169.254.169.254/latest/meta-data/placement/availability-zone)

            cat > /var/www/html/index.html <<HTML
            <html>
                <head>
                <title>3-Tier AWS Architecture</title>
                </head>

                <body>
                <center>
                    <h1>Highly Available 3-Tier Architecture</h1>
                    <h2>Web Tier</h2>
                    <p>Availability Zone: $EC2AZ</p>
                </center>
                </body>
            </html>
            HTML
        EOF
    )
}






resource "aws_launch_template" "app" {
    name = "${var.project_name}-AppLT"
    description = "Application tier launch template"
    image_id =  data.aws_ami.ubuntu.id

    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.app.id]
    key_name = var.key_name
    network_interfaces {
      associate_carrier_ip_address = true
      security_groups = [aws_security_group.app.id]
    }

    tag_specifications {
      resource_type = "instance"
       tags = {
            Name = "AppServer"
            Tier = "Application"
        }
    }

    lifecycle {
      create_before_destroy = true
    }

    user_data = base64encode(
        <<-EOF
            #!/bin/bash

            apt-get update -y
            apt-get install -y apache2 curl

            systemctl enable apache2
            systemctl start apache2

            TOKEN=$(curl -X PUT -s \
                -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" \
                http://169.254.169.254/latest/api/token)

            EC2AZ=$(curl -s \
                -H "X-aws-ec2-metadata-token: $TOKEN" \
                http://169.254.169.254/latest/meta-data/placement/availability-zone)

            cat > /var/www/html/index.html <<HTML
            <html>
                <head>
                <title>Application Tier</title>
                </head>

                <body>
                <center>
                    <h1>Application Tier</h1>
                    <p>Availability Zone: $EC2AZ</p>
                </center>
                </body>
            </html>
            HTML
        EOF
    )
}