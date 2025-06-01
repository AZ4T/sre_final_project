// modules/network-sgs/outputs.tf

output "app_sg_id" {
  description = "ID of the application SG"
  value       = aws_security_group.app_sg.id
}

output "db_sg_id" {
  description = "ID of the DB SG"
  value       = aws_security_group.db_sg.id
}

output "monitor_sg_id" {
  description = "ID of the monitoring SG"
  value       = aws_security_group.monitor_sg.id
}
