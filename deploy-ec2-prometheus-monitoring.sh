#!/bin/bash
# Script to deploy Prometheus monitoring
# Usage: ./deploy-monitoring.sh [environment] [options]
#   environment: prod, staging, local (default: local)
#   options: --force (forces recreation of containers)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

ENV=${1:-local}
FORCE_RECREATE=""

# Process arguments
if [[ "$*" == *"--force"* ]]; then
  FORCE_RECREATE="force_recreate=true"
fi

# Check if ansible is installed
if ! command -v ansible-playbook &> /dev/null; then
  echo "Ansible is not installed. Please install it first."
  exit 1
fi

# Verify if inventory exists
if [ ! -f "inventory.ini" ]; then
  echo "inventory.ini not found. Please make sure it exists."
  exit 1
fi


# ip_10_120_27_163
# ip_10_120_20_100 
# Deploy based on environment
case "$ENV" in
  prod)
    echo "Deploying Prometheus monitoring to PRODUCTION environment..."
    ansible-playbook -i inventory/aws_ec2.yaml playbook_prometheus_monitoring.yml \
      --tags prod --limit 'ip_10_120_27_163' --connection ssh -u ubuntu  ${FORCE_RECREATE:+--extra-vars "$FORCE_RECREATE"}
    ;;
  local)
    echo "Deploying Prometheus monitoring to LOCAL environment..."
    ansible-playbook -i inventory.ini playbook_prometheus_monitoring.yml \
      --tags local --connection local ${FORCE_RECREATE:+--extra-vars "$FORCE_RECREATE"}
    ;;
  *)
    echo "Unknown environment: $ENV"
    echo "Usage: ./deploy-monitoring.sh [environment] [options]"
    echo "  environment: prod, local (default: local)"
    echo "  options: --force (forces recreation of containers)"
    exit 1
    ;;
esac

echo "Deployment completed successfully!" 