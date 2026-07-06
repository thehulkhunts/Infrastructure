instances = {
  "bastion_host" = {
    instance_type = ["t2.medium", "t2.small"]
    volume_size   = 8
    volume_type   = "gp2"
    key_name      = "godevops"
  }
}