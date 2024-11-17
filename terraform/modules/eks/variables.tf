variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for the EKS cluster"
  type        = list(string)
}

variable "node_desired_capacity" {
  description = "Desired capacity of the EKS node group"
  default     = 2
}

variable "node_min_capacity" {
  description = "Minimum capacity of the EKS node group"
  default     = 1
}

variable "node_max_capacity" {
  description = "Maximum capacity of the EKS node group"
  default     = 4
}

variable "ssh_key_name" {
  description = "SSH key name for accessing EC2 nodes"
  type        = string
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
  default     = {}
}

