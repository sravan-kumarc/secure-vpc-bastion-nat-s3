##Secure VPC with Bastion Host, NAT Gateway, and S3 Integration
This repository provides a Terraform configuration to deploy a secure AWS Virtual Private Cloud (VPC) architecture with public and private subnets, a bastion host for secure access, a NAT Gateway for outbound traffic, and an S3 bucket for storage. The setup follows AWS best practices for security and scalability, ensuring a robust infrastructure for production environments.
Table of Contents

Architecture Overview
Features
Prerequisites
Installation
Usage
Directory Structure
Security Considerations
Contributing

Architecture Overview
The architecture includes:

VPC: A Virtual Private Cloud with a CIDR block to isolate your resources.
Public Subnets: Host the bastion host and NAT Gateway, accessible from the internet.
Private Subnets: Host application instances with no direct internet access, ensuring enhanced security.
Bastion Host: An EC2 instance in the public subnet for secure SSH access to private instances.
NAT Gateway: Enables private instances to access the internet for updates without exposing them.
S3 Bucket: A secure storage bucket for storing application data or logs.
Security Groups: Restrict traffic to ensure only necessary ports (e.g., SSH on port 22) are open.
IAM Roles: Provide least-privilege access for resources interacting with the S3 bucket.

Features

Secure Access: Bastion host for SSH access to private instances, minimizing exposure.
Outbound Connectivity: NAT Gateway allows private instances to access the internet securely.
Scalable Design: Supports multiple availability zones for high availability.
Storage Integration: S3 bucket for secure and durable storage.
Infrastructure as Code: Fully automated deployment using Terraform.
Customizable: Easily modify CIDR blocks, instance types, and other configurations.

Prerequisites
Before you begin, ensure you have the following:

AWS Account: Active AWS account with sufficient permissions.
Terraform: Installed (version 1.0.0 or later).
AWS CLI: Configured with credentials (aws configure).
SSH Key Pair: An EC2 key pair for bastion host access.
Git: Installed to clone this repository.

Installation

Clone the Repository:
git clone https://github.com/sravan-kumarc/secure-vpc-bastion-nat-s3.git
cd secure-vpc-bastion-nat-s3


Initialize Terraform:
terraform init


Configure Variables:

Copy terraform.tfvars.example to terraform.tfvars.
Update terraform.tfvars with your AWS region, key pair name, and other custom settings.

Example terraform.tfvars:
region          = "us-east-1"
vpc_cidr        = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
key_name        = "my-key-pair"


Review and Apply:

Preview the resources to be created:terraform plan


Deploy the infrastructure:terraform apply





Usage

Access the Bastion Host:

Use the SSH key pair to connect to the bastion host:ssh -i <your-key>.pem ec2-user@<bastion-public-ip>


From the bastion host, SSH into private instances using their private IP addresses.


Access the S3 Bucket:

Use AWS CLI or SDK to interact with the S3 bucket:aws s3 cp myfile.txt s3://<bucket-name>/




Verify NAT Gateway:

Confirm private instances can access the internet (e.g., run curl https://www.example.com from a private instance via the bastion host).


Cleanup:

To destroy the infrastructure:terraform destroy





Directory Structure
secure-vpc-bastion-nat-s3/
├── main.tf               # Main Terraform configuration
├── variables.tf          # Input variables
├── outputs.tf            # Output variables (e.g., bastion public IP, S3 bucket name)
├── terraform.tfvars.example # Example variable file
└── README.md             # This file

Security Considerations

Bastion Host: Restrict SSH access to specific IP ranges in the security group.
Security Groups: Ensure least-privilege access (e.g., allow only port 22 for SSH).
S3 Bucket: Enable versioning and encryption for enhanced security.
IAM Roles: Assign minimal permissions for EC2 instances accessing S3.
SSH Key Management: Avoid copying private keys to the bastion host; use SSH agent forwarding instead.

Contributing
Contributions are welcome! Please follow these steps:

Fork the repository.
Create a new branch (git checkout -b feature-branch).
Commit your changes (git commit -m "Add new feature").
Push to the branch (git push origin feature-branch).
Open a pull request.
