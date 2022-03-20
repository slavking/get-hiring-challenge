variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region to deploy to"
}

variable "public-vpc-name" {
  type        = string
  default     = "stef-public-vpc"
  description = "Public VPC name"
}


variable "instance-size" {
  type        = string
  default     = "t2.micro"
  description = "Instance size - default t2.micro"
}