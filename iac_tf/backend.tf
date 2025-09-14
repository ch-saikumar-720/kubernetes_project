terraform {
  backend "s3" {
    bucket  = "my-terraform-state-us-east1-unique"
    key     = "project_2/kubernetes_project/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
