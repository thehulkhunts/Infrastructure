#terraform {
  #backend "s3" {
    #bucket         = "vin-ultimate-bucket" //provide your unique bucket name
    #region         = "ap-south-1"
    #key            = "dev/terraform.tfstate"
   # dynamodb_table = "terraform-locks"
  #  encrypt        = true
 # }
#}

// create dynamo db table and bucket in s3 before applying it to infra..