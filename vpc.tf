module "stef-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.public-vpc-name
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  create_igw         = true

  tags = var.tags
}

module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = module.stef-vpc.vpc_id
  security_group_ids = [aws_security_group.lambda-sg.id]

  endpoints = {

    sns = {
      service    = "sns"
      subnet_ids = [module.stef-vpc.private_subnets[0]]
      tags       = var.tags
    }

  }

  tags = var.tags
}