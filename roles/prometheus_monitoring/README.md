# Prometheus Monitoring Role

This Ansible role deploys a Prometheus monitoring stack using Docker Compose, including:

- Prometheus Agent (for metrics collection and remote writing)
- Node Exporter (for system metrics)
- cAdvisor (for container metrics)

## Requirements

- Docker installed on the target host
- Docker Compose v2.x installed on the target host
- Ansible 2.9 or higher

## Role Variables

All variables are defined in `defaults/main.yml` with sensible defaults:

```yaml
# Docker Compose version
docker_compose_version: "v2.20.0"

# Service versions
node_exporter_version: "v1.8.1"
cadvisor_version: "v0.47.2"
prometheus_version: "v2.52.0"

# Installation directory
install_dir: "/opt/prometheus-monitoring"

# Prometheus configuration
prometheus_config_dir: "{{ install_dir }}/config"
prometheus_data_dir: "{{ install_dir }}/data"

# Port configurations
node_exporter_port: 9100
cadvisor_port: 8080
prometheus_port: 9090

# Resource limits
node_exporter_memory_limit: "256M"
node_exporter_cpu_limit: "0.5"
cadvisor_memory_limit: "512M"
cadvisor_cpu_limit: "0.5"
prometheus_memory_limit: "1G"
prometheus_cpu_limit: "1.0"

# Remote write configuration
prometheus_remote_write_url: "https://prometheus-prod.provenance.ai/api/v1/write"

# Health check configuration
health_check_interval: "30s"
health_check_timeout: "10s"
health_check_retries: 3
```

## Additional Variables

- `force_recreate`: (default: false) - When set to true, this will force the Docker Compose stack to be recreated even if it's already running.

## Dependencies

None.

## Example Playbook

```yaml
- hosts: monitoring_servers
  become: yes
  roles:
    - role: prometheus_monitoring
      vars:
        install_dir: "/opt/my-monitoring"
        prometheus_remote_write_url: "https://my-prometheus-server/api/v1/write"
```

## Pre-checks

The role performs the following pre-checks before installation:

1. Verifies Docker is installed
2. Verifies Docker Compose is installed
3. Checks if the Docker Compose version is compatible with the recommended version
4. Checks if any of the monitoring containers are already running

## License

MIT

## Author Information

Your DevOps Team
