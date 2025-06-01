// modules/db/outputs.tf

output "db_endpoint" {
  description = "RDS endpoint address"
  value       = aws_db_instance.this.endpoint
}

output "db_port" {
  description = "RDS port"
  value       = aws_db_instance.this.port
}
