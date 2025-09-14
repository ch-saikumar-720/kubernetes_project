terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"                      # Replace with your S3 bucket
    key            = "project_2/kubernetes_project/terraform.tfstate" # Path inside the bucket
    region         = "us-east-1"                                      # AWS region
    dynamodb_table = "terraform-locks"                                # Optional: for state locking
    encrypt        = true
  }
}

