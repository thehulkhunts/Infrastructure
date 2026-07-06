
resource "aws_instance" "ec2_instances" {
  for_each = var.instances
  ami = data.aws_ami.latest.id
  instance_type = each.value.instance_type
  key_name = each.value.key_name
  subnet_id = var.subnet_id[tonumber(split("_", each.key)[1]) % length(var.subnet_id)]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = each.value.volume_size
    volume_type = each.value.volume_type
  }
  tags = {
    "Name" = "${var.environment}-instances"
     Environment = var.environment
  }
}

data "aws_ami" "latest" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "image-id"
    values = [data.aws_ssm_parameter.ami_id.value]
  }
}

data "aws_ssm_parameter" "ami_id" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

//create security group for ec2instance to allow ports

resource "aws_security_group" "ec2_sg" {
  name        = "${var.environment}-ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }
    dynamic "egress" {
        for_each = local.egress_rules
        content {
        from_port   = egress.value.from_port
        to_port     = egress.value.to_port
        protocol    = egress.value.protocol
        cidr_blocks = egress.value.cidr_blocks
        description = egress.value.description
        }
    }
 }

 locals {
  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH access from anywhere"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP access from anywhere"
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
 }