// terraform/_main.tf

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

#################################################
# 1) VPC Module
#################################################
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr_block      = var.vpc_cidr_block
  vpc_name            = var.vpc_name
  public_subnet_cidrs = var.public_subnet_cidrs
  public_azs          = var.public_azs
  subnet_name_prefix  = var.subnet_name_prefix
  igw_name            = var.igw_name
  route_table_name    = var.route_table_name
}

#################################################
# 2) Networking / Security Groups Module
#################################################
module "network_sgs" {
  source = "./modules/network-sgs"

  vpc_id             = module.vpc.vpc_id
  app_sg_name        = var.app_sg_name
  app_port           = var.app_port
  app_ingress_cidrs  = var.app_ingress_cidrs
  ssh_allowed_cidrs  = var.ssh_allowed_cidrs

  db_sg_name         = var.db_sg_name
  db_port            = var.db_port

  monitor_sg_name    = var.monitor_sg_name
  monitor_ingress_cidrs = var.monitor_ingress_cidrs
}

#################################################
# 3) App Module (ASG + ALB)
#################################################
module "app" {
  source = "./modules/app"

  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = module.vpc.public_subnet_ids
  app_sg_id            = module.network_sgs.app_sg_id

  ami_id               = var.ami_id_app
  instance_type        = var.instance_type_app
  key_pair_name        = var.key_pair_name
  app_port             = var.app_port
  alb_name             = var.alb_name
  app_name_prefix      = var.app_name_prefix
  health_check_path    = var.health_check_path

  asg_min_size         = var.asg_min_size
  asg_max_size         = var.asg_max_size
  asg_desired_capacity = var.asg_desired_capacity
  asg_tags             = { "Project" = "SRE_Final" }
}

#################################################
# 4) Database Module (RDS Multi-AZ)
#################################################
module "db" {
  source = "./modules/db"

  db_identifier         = var.db_identifier
  db_engine             = var.db_engine
  db_engine_version     = var.db_engine_version
  db_instance_class     = var.db_instance_class
  db_username           = var.db_username
  db_password           = var.db_password
  db_allocated_storage  = var.db_allocated_storage
  db_storage_type       = var.db_storage_type
  db_backup_retention   = var.db_backup_retention
  private_subnet_ids    = var.private_subnet_ids
  db_sg_id              = module.network_sgs.db_sg_id
}

#################################################
# 5) Monitoring Module (Prometheus + Grafana)
#################################################
module "monitoring" {
  source = "./modules/monitoring"

  ami_id             = var.ami_id_monitor
  instance_type      = var.instance_type_monitor
  public_subnet_ids  = module.vpc.public_subnet_ids
  key_pair_name      = var.key_pair_name
  monitor_sg_id      = module.network_sgs.monitor_sg_id
  instance_name      = var.instance_name_monitor

  prometheus_port    = var.prometheus_port
  grafana_port       = var.grafana_port
  node_exporter_port = var.node_exporter_port
  app_metrics_port   = var.app_metrics_port
}

#################################################
# 6) (Optional) Outputs
#################################################
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "app_alb_dns" {
  description = "App ALB DNS name"
  value       = module.app.alb_dns_name
}

output "app_asg_name" {
  description = "App ASG name"
  value       = module.app.asg_name
}

output "db_endpoint" {
  description = "RDS endpoint"
  value       = module.db.db_endpoint
}

output "monitoring_ip" {
  description = "Public IP of monitoring instance"
  value       = module.monitoring.monitoring_public_ip
}
