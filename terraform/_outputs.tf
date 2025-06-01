##############################################################################
# outputs.tf
##############################################################################

output "monitoring_instance_id" {
  description = "The ID of the monitoring EC2 instance"
  value       = aws_instance.monitoring.id
}

output "monitoring_public_ip" {
  description = "Public IP address of the monitoring EC2 instance"
  value       = aws_instance.monitoring.public_ip
}

output "monitoring_public_dns" {
  description = "Public DNS (hostname) of the monitoring EC2 instance"
  value       = aws_instance.monitoring.public_dns
}
