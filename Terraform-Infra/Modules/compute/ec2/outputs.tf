output "instance_ip" {
  value = {
    for k, instance in aws_instance.ec2_instances :
    k => instance.public_ip
  }
}