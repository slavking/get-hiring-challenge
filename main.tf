provider "aws" {
  region = var.region
  version = "4.6.0"
}

terraform {
  backend "s3" {
    bucket = "stefan-test-sync-bucket"
    key    = "terraform/state"
    region = "us-east-1"
  }
}