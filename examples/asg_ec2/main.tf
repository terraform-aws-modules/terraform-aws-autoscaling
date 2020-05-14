provider "aws" {
  region = "us-east-2"
}


##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################
module "vpc" {
  source = "github.com/youse-seguradora/terraform-aws-vpc"

  name = var.vpc_name

  cidr = "192.168.253.0/24"

  azs                    = ["us-east-2a"]
  compute_public_subnets = ["192.168.253.0/24"]
}

data "aws_security_group" "default" {
  vpc_id = module.vpc.vpc_id
  name   = "default"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name = "name"
    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }
}

resource "aws_iam_service_linked_role" "autoscaling" {
  aws_service_name = "autoscaling.amazonaws.com"
  description      = "A service linked role for autoscaling"
  custom_suffix    = "something"

  # Sometimes good sleep is required to have some IAM resources created before they can be used
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

locals {
  user_data = <<EOF
#!/bin/bash
echo "Hello Terraform!"
EOF
}

######
# Launch configuration and autoscaling group
######
module "example" {
  source = "../../"

  name = "example-with-ec2"

  # Launch configuration
  #
  # launch_configuration = "my-existing-launch-configuration" # Use the existing launch configuration
  # create_lc = false # disables creation of launch configuration
  lc_name = var.lc_name

  image_id                     = data.aws_ami.amazon_linux.id
  instance_type                = "t2.micro"
  security_groups              = [data.aws_security_group.default.id]
  associate_public_ip_address  = true
  recreate_asg_when_lc_changes = true

  user_data_base64 = base64encode(local.user_data)

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "8"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size           = "8"
      volume_type           = "gp2"
      delete_on_termination = true
    },
  ]

  # Auto scaling group
  asg_name                  = var.asg_name
  vpc_zone_identifier       = module.vpc.public_subnets
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 0
  wait_for_capacity_timeout = 0
  service_linked_role_arn   = aws_iam_service_linked_role.autoscaling.arn

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
  ]

  tags_as_map = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }
}
