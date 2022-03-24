provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "stefan-test-sync-bucket"
    key    = "terraform/state"
    region = "us-east-1"
  }
}