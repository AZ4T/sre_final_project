// modules/monitoring/outputs.tf

output "monitoring_instance_id" {
  description = "ID of the monitoring EC2 instance"
  value       = aws_instance.monitoring_instance.id
}

output "monitoring_public_ip" {
  description = "Public IP of the monitoring EC2"
  value       = aws_instance.monitoring_instance.public_ip
}
