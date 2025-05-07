#!/bin/sh

INSTANCE_ID=$(wget -qO- http://169.254.169.254/latest/meta-data/instance-id)
INSTANCE_TYPE=$(wget -qO- http://169.254.169.254/latest/meta-data/instance-type)
AZ=$(wget -qO- http://169.254.169.254/latest/meta-data/placement/availability-zone)
INSTANCE_NAME=$(wget -qO- http://169.254.169.254/latest/meta-data/tags/instance/Name)

cat <<EOF > /etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'ec2-node-exporter'
    static_configs:
      - targets: ['node-exporter:9100']
    relabel_configs:
      - target_label: instance_id
        replacement: "$INSTANCE_NAME"
      - target_label: instance_type
        replacement: "$INSTANCE_TYPE"
      - target_label: availability_zone
        replacement: "$AZ"

  - job_name: 'ec2-cadvisor'
    static_configs:
      - targets: ['cadvisor:8080']
    relabel_configs:
      - target_label: instance_id
        replacement: "$INSTANCE_NAME"
      - target_label: instance_type
        replacement: "$INSTANCE_TYPE"
      - target_label: availability_zone
        replacement: "$AZ"

remote_write:
  - url: "https://prometheus-prod.provenance.ai/api/v1/write"
EOF

exec /bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/prometheus \
  --web.enable-lifecycle \
  --enable-feature=agent-mode

#https://grafana.com/grafana/dashboards/1860 
#https://grafana.com/grafana/dashboards/193 