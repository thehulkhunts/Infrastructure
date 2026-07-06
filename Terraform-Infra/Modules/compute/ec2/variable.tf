variable "vpc_id" {
  type = string
  description = "define vpc id"
}

variable "environment" {
  type = string
  description = "provide environment at tfvarfile"
}

variable "instances" {
  type = map(object({
    instance_type = list(string)
    volume_size = string
    volume_type = string
    key_name = string
  }))
}

variable "subnet_id" {
  type = list(string)
}