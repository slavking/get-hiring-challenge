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
    values = ["x86_64"]
  }
  owners = ["amazon"]
}


locals {
  latest_azn_lnx_ami = data.aws_ami.latest_amazon_linux_2.id
  public_subnet_id   = module.stef-vpc.public_subnets
  vpc_id             = module.stef-vpc.vpc_id
  key_name           = "stef-pubkey"
  stef-sg            = "stef-security-group"
}

resource "aws_security_group" "sg" {
  name   = local.stef-sg
  vpc_id = local.vpc_id
}

resource "aws_security_group_rule" "ingress_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]

  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sg.id
}
resource "aws_key_pair" "ssh" {
  key_name   = local.key_name
  public_key = file("./pubkey/id_rsa.pub")
}

module "ec2_instance" {

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = local.latest_azn_lnx_ami
  instance_type          = var.instance-size
  key_name               = local.key_name
  monitoring             = true
  vpc_security_group_ids = aws_security_group.sg.id
  subnet_id              = local.public_subnet_id
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

