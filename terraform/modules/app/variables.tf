// modules/app/variables.tf

variable "vpc_id" {
  description = "VPC ID where app instances will run"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "app_sg_id" {
  description = "Security Group ID for app instances"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for application instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the app (e.g., t3.micro)"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the EC2 Key Pair to attach to instances"
  type        = string
}

variable "app_port" {
  description = "Port the application listens on"
  type        = number
}

variable "alb_name" {
  description = "Name prefix for the ALB"
  type        = string
}

variable "app_name_prefix" {
  description = "Name prefix for app resources (ASG, LT, etc.)"
  type        = string
}

variable "health_check_path" {
  description = "ALB health check path"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum number of app instances"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum number of app instances"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired capacity for app ASG"
  type        = number
}

variable "asg_tags" {
  description = "Map of tags to apply to ASG instances"
  type        = map(string)
  default     = {}
}
