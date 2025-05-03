# Ansible Infrastructure Management

This repository contains Ansible playbooks and configurations for managing infrastructure using both SSH and AWS SSM connections.

## Features

- Dual connection methods (SSH and AWS SSM)
- Docker Compose monitoring stack deployment
- Scalable inventory management
- Infrastructure validation playbooks

## Prerequisites

- Ansible 2.9 or later
- Python 3.6 or later
- AWS CLI configured with appropriate credentials (for SSM connections)
- SSH key pair for remote connections
- Docker and Docker Compose (for monitoring stack deployment)



## Configuration


### SSH Configuration

The `sample-ssh-config` file provides a template for SSH connections:

```
Host *
    IdentityFile ~/.ssh/id_rsa
    PreferredAuthentications publickey
    StrictHostKeyChecking no
```

## Usage

### Testing AWS SSM Connectivity

```bash
# Test connectivity to SSM-managed hosts
ansible-playbook playbooks/ssm_ping.yaml -i inventory/inventory.ini

# Limit to specific hosts
ansible-playbook playbooks/ssm_ping.yaml -i inventory/inventory.ini -l aws-instance-1
```


## Monitoring Stack

The monitoring stack includes:

- **Node Exporter**: Collects system metrics (CPU, memory, disk, network)
- **cAdvisor**: Gathers container metrics
- Deployed via Docker Compose for easy setup and scalability

## Best Practices

- Use environment variables or Ansible Vault for sensitive information
- Follow the principle of least privilege for all connections
- Implement tags for flexible task execution
- Use handlers for service restarts
- Test playbooks in a development environment before production deployment

## Troubleshooting

- For SSH connection issues, verify key permissions and host accessibility
- For SSM connection problems, check AWS credentials and IAM permissions
- Validate playbook syntax with `ansible-playbook --syntax-check`

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-playbook`)
3. Commit your changes (`git commit -am 'Add new playbook for XYZ'`)
4. Push to the branch (`git push origin feature/new-playbook`)
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
