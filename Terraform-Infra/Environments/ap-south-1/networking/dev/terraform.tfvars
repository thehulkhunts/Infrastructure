vpc_cidr              = "10.0.0.0/16"
environment           = "dev"
public_subnets_cidrs  = ["10.0.1.0/24", "10.0.3.0/24"]
private_subnets_cidrs = ["10.0.2.0/24", "10.0.4.0/24"]
availability_zones    = ["ap-south-1a", "ap-south-1b"]

instances = {
  "bastion_host" = {
    instance_type = ["t2.medium", "t2.small"]
    volume_size   = 8
    volume_type   = "gp2"
    key_name      = "godevops"
  }
}

