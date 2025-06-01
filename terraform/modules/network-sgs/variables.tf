// modules/network-sgs/variables.tf

variable "vpc_id" {
  description = "ID of the VPC where SGs will be created"
  type        = string
}

variable "app_sg_name" {
  description = "Name for the application security group"
  type        = string
}

variable "app_port" {
  description = "Port the app listens on (e.g., 8080 or 80)"
  type        = number
  default     = 8080
}

variable "app_ingress_cidrs" {
  description = "List of CIDR blocks allowed to access the app"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ssh_allowed_cidrs" {
  description = "CIDRs allowed to SSH to app servers"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "db_sg_name" {
  description = "Name for the database security group"
  type        = string
}

variable "db_port" {
  description = "Port used by the database (e.g., 3306 for MySQL, 5432 for Postgres)"
  type        = number
  default     = 5432
}

variable "monitor_sg_name" {
  description = "Name for the monitoring security group"
  type        = string
}

variable "monitor_ingress_cidrs" {
  description = "CIDRs allowed to access Prometheus/Grafana ports"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
