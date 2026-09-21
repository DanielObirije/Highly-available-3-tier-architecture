resource "aws_db_subnet_group" "db_subnet" {
   name =  "${var.project_name}-dbsub"
   subnet_ids =  aws_subnet.db_pri_sub[*].id 
   tags = {
    Name = "${var.project_name}-DBSub"
  }
}

resource "aws_db_instance" "main" {
    identifier =  "${var.project_name}-db"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = var.db_instance_class
    allocated_storage = 20
    storage_type = "gp3"
    storage_encrypted = true
    db_name = "${var.project_name}-db"
    username = var.db_username
    password = var.db_password
    port = 3306
    db_subnet_group_name = aws_db_subnet_group.db_subnet.name
    vpc_security_group_ids =[aws_security_group.db.id]
    multi_az = false
    publicly_accessible = false
    backup_retention_period = 0
    backup_window = "03:00-04:00"
    maintenance_window = "sun:04:00-sun:05:00"
    skip_final_snapshot = true
    deletion_protection = false
    auto_minor_version_upgrade = true

    tags = {
       Name = "${var.project_name}-MySQL"
       Tier = "Database"
    }
}