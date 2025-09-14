# Provider
provider "aws" {
  region = "us-east-1"
}

# Data source for default VPC
data "aws_vpc" "default" {
  default = true
}

# Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg_${var.env}"
  description = "Security group for EC2 instances"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg_${var.env}"
  }
}

# EC2 Instance
resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "terraform-ec2-instance-${var.env}"
  }
}
