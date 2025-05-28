resource "aws_db_instance" "mysql" {
  allocated_storage    = var.allocated_storage
  engine               = "mysql"
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  identifier           = var.db_name
  username             = var.username
  manage_master_user_password = true
  parameter_group_name = var.parameter_group_name
  publicly_accessible  = false
  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name = aws_db_subnet_group.mysql.name

  # set a final snapshot before deletion  
  # final_snapshot_identifier = "${var.db_name}-final-snapshot"
  # or keep it true to skip final snapshot
  skip_final_snapshot = true

  tags = {
    Name = var.db_name
  }
}

resource "aws_db_subnet_group" "mysql" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.db_name}-subnet-group"
  }
}