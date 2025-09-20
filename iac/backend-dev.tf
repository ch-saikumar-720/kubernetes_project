terraform {
  backend "s3" {
    bucket         = "project1-dev-tfstate"   # <-- replace with your S3 bucket name
    key            = "env/dev/terraform.tfstate" # Path inside the bucket
    region         = var.region
    encrypt        = true
  }
}
