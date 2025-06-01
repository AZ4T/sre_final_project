// modules/vpc/variables.tf

variable "vpc_cidr_block" {
  description = "CIDR for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets (one per AZ)"
  type        = list(string)
}

variable "public_azs" {
  description = "List of availability zones for each public subnet"
  type        = list(string)
}

variable "subnet_name_prefix" {
  description = "Prefix to use for subnets"
  type        = string
}

variable "igw_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
}

variable "route_table_name" {
  description = "Name tag for the public route table"
  type        = string
}
