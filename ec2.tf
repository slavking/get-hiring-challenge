data "aws_ami" "latest_amazon_linux_2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["*amzn2-ami-hvm*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = [ "x86_64" ]
  }
  owners = ["amazon"]
}


locals {
  latest_azn_lnx_ami = data.aws_ami.latest_amazon_linux_2.id
  public_subnet_id = module.stef-vpc.public_subnets
}

resource "stef-sg" "s" {

}

module "ec2_instance" {

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = local.latest_azn_lnx_ami
  instance_type          = var.instance-size
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = var.stef-sg
  subnet_id              = local.public_subnet_id
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

