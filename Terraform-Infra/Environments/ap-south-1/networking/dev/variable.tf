variable "vpc_cidr" {
  type        = string
  description = "call values in *.tfvars file"
}
variable "environment" {
  type        = string
  description = "pass environment"
}

variable "private_subnets_cidrs" {
  type        = list(string)
  description = "inject multiple private cidr's"
}
variable "availability_zones" {
  type        = list(string)
  description = "pass multiple availability zones"
}

variable "public_subnets_cidrs" {
  type        = list(string)
  description = "inject multiple public cidr's"
}
variable "instances" {
  type = map(object({
    instance_type = list(string)
    volume_size   = string
    volume_type   = string
    key_name      = string
  }))
}



