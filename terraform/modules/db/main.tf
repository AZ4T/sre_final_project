// modules/db/main.tf

resource "aws_db_subnet_group" "this" {
  name       = "${var.db_identifier}-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.db_identifier}-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier               = var.db_identifier
  engine                   = var.db_engine
  engine_version           = var.db_engine_version
  instance_class           = var.db_instance_class
  username                 = var.db_username
  password                 = var.db_password
  allocated_storage        = var.db_allocated_storage
  storage_type             = var.db_storage_type
  multi_az                 = true
  publicly_accessible      = false
  db_subnet_group_name     = aws_db_subnet_group.this.name
  vpc_security_group_ids   = [var.db_sg_id]
  skip_final_snapshot      = true
  backup_retention_period  = var.db_backup_retention

  tags = {
    Name = var.db_identifier
  }
}
