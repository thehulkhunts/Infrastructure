variable "vpc_id" {
  type = string
  description = "all about vpc-id"
}
variable "public_subnets_cidrs" {
  type = list(string)
  description = "inject multiple public cidr's"
}
variable "private_subnets_cidrs" {
  type = list(string)
  description = "inject multiple private cidr's"
}
variable "availability_zones" {
  type = list(string)
  description = "pass multiple availability zones"
}
variable "environment" {
  type = string
  description = "pass environment"
}