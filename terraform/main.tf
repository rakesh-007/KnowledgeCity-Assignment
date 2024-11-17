module "frontend" {
  source      = "./modules/frontend"
  bucket_name = "knowledgecity-frontend-${random_string.suffix.result}"
}

module "eks" {
  source              = "./modules/eks"
  cluster_name        = "knowledgecity-eks"
  vpc_id              = "vpc-02e3fdd06c5debf12"
  subnet_ids          = ["subnet-0c40aa6b6302cf4eb", "subnet-0a20b88eca3d87475"]
  node_desired_capacity = 3
  node_min_capacity   = 1
  node_max_capacity   = 5
  ssh_key_name        = "knowledgecity"
  tags = {
    Environment = "Production"
  }
}

module "rds" {
  source          = "./modules/rds"
  vpc_id          = var.vpc_id
  environment     = var.environment
  database_name   = "knowledgecity_db"
  username        = "admin"
  password        = "SecurePass123"
}

module "media_server" {
  source          = "./modules/media-server"
  vpc_id          = var.vpc_id
  subnet_id       = var.public_subnet_id
  key_name        = var.key_name
  environment     = var.environment
}

module "microservice" {
  source          = "./modules/microservice"
  vpc_id          = var.vpc_id
  subnet_id       = var.public_subnet_id
  key_name        = var.key_name
  environment     = var.environment
}

resource "random_string" "suffix" {
  length  = 6
  special = false
}
