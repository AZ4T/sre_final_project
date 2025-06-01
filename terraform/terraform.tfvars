# ─── AWS Settings ─────────────────────────────────────────
aws_region  = "us-east-1"
aws_profile = "default"

# ─── Monitoring EC2 Settings ─────────────────────────────
ami_id                   = "ami-0c3ce86fb8321acb9"   # ← replace with the value from step 1
monitoring_instance_type = "t3.micro"

dockerhub_username = "az4t"   # ← your Docker Hub username

# ─── VPC & Subnet Configuration ──────────────────────────
vpc_cidr_block    = "10.0.0.0/16"
subnet_cidr_block = "10.0.1.0/24"
