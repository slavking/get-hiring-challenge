
module "sns_topic" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 3.0"

  create_sns_topic = true
  name             = local.sns_topic_name
}

resource "aws_sns_topic_subscription" "sns_subscribe_stef_email" {
  endpoint               = var.user_email
  protocol               = "email"
  topic_arn              = module.sns_topic.sns_topic_arn
  endpoint_auto_confirms = true
}

locals {
  sns_topic_name = "stef-cron-topic"
  lambda_env = { SNS_TOPIC_ARN = "${module.sns_topic.sns_topic_arn}"
  SNS_TOPIC_NAME = "${module.sns_topic.sns_topic_name}" }
  lambda-sg = "stef-lambda-sg"
}


resource "aws_security_group" "lambda-sg" {
  name   = local.lambda-sg
  vpc_id = local.vpc_id
  tags   = var.tags

  description = "Allow TLS inbound traffic"

  ingress {
    description = "all to VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "all from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


module "aws-lambda-cron" {
  source = "./aws-lambda-cron"

  function_name        = "stef-lambda-fuction"
  filename             = "./lambda/main.zip"
  handler              = "main.lambda_handler" #filename.function_handler_name
  timeout              = "900"
  runtime              = "python3.8"
  lambda_cron_schedule = "cron(0 1 * * ? *)"
  lambda_env           = local.lambda_env

  subnet_ids         = [module.stef-vpc.private_subnets[0]]
  security_group_ids = [aws_security_group.lambda-sg.id]
  # insert the 6 required variables here
  s3_bucket = null
  s3_key    = null
}