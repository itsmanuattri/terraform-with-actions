terraform {
  backend "s3" {
    bucket         = "terraform-with-actions-bucket-de-cohort"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "app_bucket" {
  source            = "../../modules/s3_bucket"
  bucket_name       = "myapp-${terraform.workspace}-bucket-de"
  enable_versioning = false

  tags = {
    env = terraform.workspace
  }
}
