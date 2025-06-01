// modules/monitoring/variables.tf

variable "ami_id" {
  description = "AMI ID for the monitoring EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for monitoring (e.g., t3.micro)"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs (pick first to launch EC2)"
  type        = list(string)
}

variable "key_pair_name" {
  description = "EC2 Key Pair for SSH"
  type        = string
}

variable "monitor_sg_id" {
  description = "SG ID to attach to monitoring EC2"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the monitoring instance"
  type        = string
}

variable "prometheus_port" {
  description = "Port on which Prometheus listens"
  type        = number
  default     = 9090
}

variable "grafana_port" {
  description = "Port on which Grafana listens"
  type        = number
  default     = 3000
}

variable "node_exporter_port" {
  description = "Port for Node Exporter"
  type        = number
  default     = 9100
}

variable "app_metrics_port" {
  description = "Port for your app’s /metrics endpoint (URL-SAS)."
  type        = number
  default     = 8080
}
