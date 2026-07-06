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

module "vpc" {
  source      = "../../../../modules/networking/vpc"
  vpc_cidr    = var.vpc_cidr
  environment = var.environment
}

module "subnets" {
  source                = "../../../../modules/networking/subnets"
  vpc_id                = module.vpc.vpc_id
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  availability_zones    = var.availability_zones
  environment           = var.environment
}

module "ec2" {
  source      = "../../../../modules/compute/ec2"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
  instances   = var.instances
  subnet_id   = module.subnets.public_subnet_ids
}

