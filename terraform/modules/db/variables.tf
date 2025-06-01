// modules/db/variables.tf

variable "db_identifier" {
  description = "Identifier (name) for the RDS instance"
  type        = string
}

variable "db_engine" {
  description = "Database engine (e.g., postgres, mysql)"
  type        = string
}

variable "db_engine_version" {
  description = "Engine version (e.g., 13.4 for PostgreSQL)"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class (e.g., db.t3.micro)"
  type        = string
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
}

variable "db_password" {
  description = "Master password for RDS"
  type        = string
  sensitive   = true
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
}

variable "db_storage_type" {
  description = "Storage type (gp2, io1, etc.)"
  type        = string
  default     = "gp2"
}

variable "db_backup_retention" {
  description = "Number of days to keep backups"
  type        = number
  default     = 7
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for RDS Multi-AZ"
  type        = list(string)
}

variable "db_sg_id" {
  description = "Security Group ID for RDS"
  type        = string
}
