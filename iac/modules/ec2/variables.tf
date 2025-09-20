variable "ami_id" {
  type        = string
  description = "AMI ID"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
  default     = "my-keypair"
}
