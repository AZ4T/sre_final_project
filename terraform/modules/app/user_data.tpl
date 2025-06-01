#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start

# Run Node Exporter
docker run -d --name=node_exporter -p 9100:9100 prom/node-exporter

# Run URL-SAS (your Node.js app/container)
# We assume your image is already pushed to ECR or DockerHub
docker run -d --name=url-sas -p ${app_port}:${app_port} az4t/url-sas:latest
