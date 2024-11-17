module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.27"
  subnets         = var.subnet_ids
  vpc_id          = var.vpc_id

  node_groups = {
    api_node_group = {
      desired_capacity = var.node_desired_capacity
      max_capacity     = var.node_max_capacity
      min_capacity     = var.node_min_capacity

      instance_types = ["t3.medium"] # Adjust based on workload
      key_name       = var.ssh_key_name

      iam_role_additional_policies = [
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      ]
    }
  }

  manage_aws_auth = true
}

# IAM Role for API Pods
resource "aws_iam_role" "api_pod_role" {
  name = "${var.cluster_name}-api-pod-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_policy_attachment" "api_policy_attachment" {
  name       = "attach-api-pod-policy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  roles      = [aws_iam_role.api_pod_role.name]
}

# Security Group for EKS Cluster
resource "aws_security_group" "eks_cluster_sg" {
  name   = "${var.cluster_name}-eks-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
