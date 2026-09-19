data "aws_ami" "ubuntu_sql" {
  most_recent = true
  owners      = ["0635373732"]

  filter {
    name   = "image-id"
    values = ["ami-091b599f5f318ddd2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "ena-support"
    values = ["true"]
  }
}
