variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "highly available 3-tier architecture"
  type        = string
  default     = "project"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets" {
  description = "Subnet CIDRs for client, database, and server"
  type = object({
    client = list(string)
    database = list(string)
    server = list(string)
  })

  default = {
    client = [
      "10.0.1.0/24",
      "10.0.2.0/24"
    ]

    database = [
      "10.0.11.0/24",
      "10.0.12.0/24"
    ]

    server = [
      "10.0.21.0/24",
      "10.0.22.0/24"
    ]
  }
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)

  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}


variable "key_name" {
  description = "AWS key pair name"
  type        = string
  default     = "project-KP"
}

variable "ssh_cidr" {
  description = "CIDR allowed to SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "projectdb"
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
  default = "admin2551"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}