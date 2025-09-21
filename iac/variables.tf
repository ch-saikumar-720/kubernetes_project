variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "key_name" {
  description = "Name of the existing AWS key pair to use for SSH"
  type        = string
}

variable "project_name" { default = "custom-vpc" }
variable "eks_version" { default = "1.29" }
variable "eks_cluster_role_arn" {}
variable "eks_node_role_arn" {}
variable "node_instance_type" { default = "t3.medium" }
variable "desired_capacity" { default = 2 }

# VPC
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "private_subnet_cidrs" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "azs" {
  default = ["us-east-1a", "us-east-1b"]
}
