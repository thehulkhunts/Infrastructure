data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "vin-ultimate-bucket" //provide your unique bucket name
    key    = "networking/dev/terraform.tfstate"
    region = "ap-south-1"
  }
}