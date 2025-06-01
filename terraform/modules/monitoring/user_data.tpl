#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start

# --- Node Exporter
docker run -d --name=node_exporter -p ${node_exporter_port}:${node_exporter_port} prom/node-exporter

# --- Prometheus (mount config and rules)
mkdir -p /etc/prometheus/rules
# Usually, you’d copy prometheus.yml and rules from EFS or a bootstrap script;
# here we assume they’re already on the EC2 via user_data or AMI.
docker run -d \
  --name=prometheus \
  -p ${prometheus_port}:${prometheus_port} \
  -v /etc/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:ro \
  -v /etc/prometheus/rules:/etc/prometheus/rules:ro \
  prom/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --web.enable-lifecycle

# --- Grafana (no provisioning files yet)
mkdir -p /etc/grafana/provisioning
docker run -d --name=grafana \
  -p ${grafana_port}:${grafana_port} \
  -e "GF_SECURITY_ADMIN_PASSWORD=admin" \
  -v /etc/grafana/provisioning/:/etc/grafana/provisioning/ \
  grafana/grafana

# Optionally, set up your URL-SAS container here if you want to scrape /metrics from it.
# docker run -d --name=url-sas -p ${app_metrics_port}:${app_metrics_port} myorg/url-sas:latest
