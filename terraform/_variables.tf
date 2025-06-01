// terraform/_variables.tf

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name"
  type        = string
  default     = "default"
}

# VPC inputs
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "sre-vpc"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs (one per AZ)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_azs" {
  description = "List of AZs for public subnets (match count of public_subnet_cidrs)"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "subnet_name_prefix" {
  description = "Prefix to apply to each subnet Name tag"
  type        = string
  default     = "sre-subnet"
}

variable "igw_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
  default     = "sre-igw"
}

variable "route_table_name" {
  description = "Name tag for the public route table"
  type        = string
  default     = "sre-public-rt"
}

# Networking / SG inputs
variable "app_sg_name" {
  description = "SG name for app servers"
  type        = string
  default     = "sre-app-sg"
}

variable "app_port" {
  description = "Port for your application (e.g. 8080)"
  type        = number
  default     = 8080
}

variable "app_ingress_cidrs" {
  description = "CIDR blocks allowed to access the app"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ssh_allowed_cidrs" {
  description = "CIDR blocks allowed to SSH to instances"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "db_sg_name" {
  description = "SG name for RDS"
  type        = string
  default     = "sre-db-sg"
}

variable "monitor_sg_name" {
  description = "SG name for monitoring servers"
  type        = string
  default     = "sre-monitoring-sg"
}

variable "monitor_ingress_cidrs" {
  description = "CIDRs allowed to reach monitoring ports"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# App ASG inputs
variable "ami_id_app" {
  description = "AMI ID for app servers"
  type        = string
  default     = "ami-0c3ce86fb8321acb9" // replace with latest Amazon Linux 2
}

variable "instance_type_app" {
  description = "EC2 instance type for app servers"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Name of the EC2 Key Pair to attach"
  type        = string
  default     = "azat-key"   # or your keypair
}

variable "alb_name" {
  description = "Name tag for the Application Load Balancer"
  type        = string
  default     = "sre-alb"
}

variable "app_name_prefix" {
  description = "Prefix used for ASG, LT, etc."
  type        = string
  default     = "sre-app"
}

variable "health_check_path" {
  description = "URL path for ALB health checks"
  type        = string
  default     = "/metrics"
}

variable "asg_min_size" {
  description = "Minimum number of app instances"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of app instances"
  type        = number
  default     = 4
}

variable "asg_desired_capacity" {
  description = "Desired capacity for app ASG"
  type        = number
  default     = 2
}

# DB inputs
variable "db_identifier" {
  description = "Identifier for RDS instance"
  type        = string
  default     = "sre-db"
}

variable "db_engine" {
  description = "DB engine"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "DB engine version"
  type        = string
  default     = "13.4"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password for RDS"
  type        = string
  default     = "ChangeMe123!"  # change to a real secret in production
}

variable "db_allocated_storage" {
  description = "GB of storage for RDS"
  type        = number
  default     = 20
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]  # if you had private subnets
}

# Monitoring inputs
variable "ami_id_monitor" {
  description = "AMI ID for monitoring EC2"
  type        = string
  default     = "ami-0c3ce86fb8321acb9"  # use the same Amazon Linux 2 AMI
}

variable "instance_type_monitor" {
  description = "Instance type for monitoring EC2"
  type        = string
  default     = "t3.micro"
}

variable "instance_name_monitor" {
  description = "Name tag for monitoring EC2"
  type        = string
  default     = "sre-monitor"
}

# (Ports for monitoring)
variable "prometheus_port" {
  type        = number
  default     = 9090
}
variable "grafana_port" {
  type        = number
  default     = 3000
}
variable "node_exporter_port" {
  type        = number
  default     = 9100
}
variable "app_metrics_port" {
  type        = number
  default     = 8080
}

# _variables.tf

# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Monitoring EC2 instance type (e.g. t3.micro, t3.small, etc.)
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
variable "monitoring_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type for the monitoring server"
}


# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Docker‐hub username (used by Terraform modules that build/push Docker images)
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
variable "dockerhub_username" {
  type        = string
  default     = "yourdockerhubusername"   # Change to your actual DockerHub user
  description = "Docker Hub username for pushing images"
}


# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# If you need a CIDR block for your subnets (for VPC or module networking)
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
variable "subnet_cidr_block" {
  type        = string
  default     = "10.0.0.0/24"
  description = "Primary CIDR block to use for application subnets"
}


# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Database (RDS) port (e.g., 3306 for MySQL, 5432 for Postgres)
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
variable "db_port" {
  type        = number
  default     = 5432
  description = "Port on which the database accepts traffic"
}


# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Database storage type (e.g. gp2, io1, gp3)
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
variable "db_storage_type" {
  type        = string
  default     = "gp2"
  description = "Storage type for the RDS instance (gp2, gp3, io1, etc.)"
}


# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# RDS Backup retention in days (e.g., 7 for one week, 14 for two weeks)
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
variable "db_backup_retention" {
  type        = number
  default     = 7
  description = "Number of days to retain automated database backups"
}
