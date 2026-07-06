provider "aws" {
  region = "ap-south-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

module "ec2" {
  source      = "../../../../modules/compute/ec2"
  vpc_id      = data.terraform_remote_state.networking.outputs.vpc_id
  environment = var.environment
  instances   = var.instances
  subnet_id   = data.terraform_remote_state.networking.outputs.public_subnet_ids
}
