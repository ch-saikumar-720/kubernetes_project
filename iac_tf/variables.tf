variable "aws_region" {
  description = "AWS region to launch resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "EC2 Key pair name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "env" {
  description = "The environment name (dev, test, prod)"
  type        = string
  default     = "dev"
}
