variable "instances" {
  type = map(object({
    instance_type = list(string)
    volume_size   = string
    volume_type   = string
    key_name      = string
  }))
}

variable "environment" {
  type        = string
  description = "pass environment"
}