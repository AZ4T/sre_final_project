// modules/network-sgs/main.tf

# Security Group for Application Servers
resource "aws_security_group" "app_sg" {
  name   = var.app_sg_name
  vpc_id = var.vpc_id

  # Allow HTTP (80) or custom port 8080 from anywhere
  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = var.app_ingress_cidrs
  }

  # Allow SSH from your office (optional)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidrs
  }

  # All outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.app_sg_name
  }
}

# Security Group for Database (RDS) – only allow from App SG
resource "aws_security_group" "db_sg" {
  name   = var.db_sg_name
  vpc_id = var.vpc_id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.db_sg_name
  }
}

# Security Group for Monitoring (Prometheus + Grafana) – allow from your IP for dashboards
resource "aws_security_group" "monitor_sg" {
  name   = var.monitor_sg_name
  vpc_id = var.vpc_id

  # Prometheus (9090), Grafana (3000), Node Exporter (9100)
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = var.monitor_ingress_cidrs
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = var.monitor_ingress_cidrs
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = var.monitor_ingress_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.monitor_sg_name
  }
}
