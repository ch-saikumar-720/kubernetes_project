module "ec2_instance" {
  source        = "./modules/ec2"
  subnet_id     = module.vpc.public_subnets[0]
  vpc_id        = module.vpc.vpc_id
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
}

module "eks" {
  source = "./modules/eks"

  project_name         = var.project_name
  eks_version          = var.eks_version
  eks_cluster_role_arn = var.eks_cluster_role_arn
  eks_node_role_arn    = var.eks_node_role_arn
  subnet_ids           = module.vpc.public_subnets
  node_instance_type   = var.node_instance_type
  desired_capacity     = var.desired_capacity
}

# VPC Module
module "vpc" {
  source               = "./modules/vpc"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}


