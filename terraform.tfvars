region     = "us-east-1"
user_email = "scolic03@gmail.com"
tags = {
  Terraform   = "true"
  Environment = "dev"
  Name        = "test-ec2"
  Description = "Test instance"
  CostCenter  = "123456"
}
instance-size  = "t2.micro"
s3_bucket_name = "stefan-test-sync-bucket"
user_subnet =  "87.116.164.0/26" #SBB subnet

