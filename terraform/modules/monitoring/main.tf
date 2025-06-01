// modules/monitoring/main.tf

resource "aws_instance" "monitoring_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[0]  # pick first public subnet
  key_name               = var.key_pair_name
  vpc_security_group_ids = [var.monitor_sg_id]
  associate_public_ip_address = true

  user_data = base64encode(templatefile("${path.module}/user_data.tpl", {
    prometheus_port = var.prometheus_port
    grafana_port    = var.grafana_port
    node_exporter_port = var.node_exporter_port
    app_metrics_port    = var.app_metrics_port
  }))

  tags = {
    Name = var.instance_name
  }
}
