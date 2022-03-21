
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
  lambda_env = sting({
    "lambda_env" : { "SNS_TOPIC_NAME" : "${module.sns_topic.sns_topic_name}" }
  })
}


module "aws-lambda-cron" {
  source = "./aws-lambda-cron"

  function_name        = "stef-lambda-fuction"
  filename             = "./lambda/main.py"
  handler              = "lambnda_handler"
  runtime              = "python3.8"
  lambda_cron_schedule = "cron(0 1 * * ? *)"
  lambda_env           = local.lambda_env

  subnet_ids         = [module.stef-vpc.public_subnets[0]]
  security_group_ids = [aws_security_group.sg.id]
  # insert the 6 required variables here
  s3_bucket = null
  s3_key    = null
}