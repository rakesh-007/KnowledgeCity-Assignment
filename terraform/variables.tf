variable "aws_region" {
  description = "AWS region to deploy the infrastructure"
  default     = "me-central-1" # Saudi Arabia region
}

variable "vpc_id" {
  description = "VPC ID where the resources will be deployed"
}

variable "public_subnet_id" {
  description = "Public Subnet ID for EC2 instances"
}

variable "key_name" {
  description = "Key pair name for EC2 instance access"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  default     = "prod"
}
