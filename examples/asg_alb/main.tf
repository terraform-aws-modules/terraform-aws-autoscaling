provider "aws" {
  region = "us-east-2"
}

##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################
module "vpc" {
  source = "github.com/youse-seguradora/terraform-aws-vpc"

  name = var.vpc_name

  cidr = "10.120.0.0/24"

  azs                    = ["us-east-2a"]
  compute_public_subnets = ["10.120.2.0/24"]
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

######
# Launch configuration and autoscaling group
######
module "example_asg" {
  source = "../../"

  name = var.asg_name


  lc_name = var.lc_name

  image_id          = data.aws_ami.amazon_linux.id
  instance_type     = "t2.micro"
  security_groups   = [data.aws_security_group.default.id]
  target_group_arns = module.alb.target_group_arns

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
      volume_size = "8"
      volume_type = "gp2"
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
}

######
# ELB
######
module "alb" {
  source = "github.com/youse-seguradora/terraform-aws-alb"


  name = var.alb_name

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [data.aws_security_group.default.id]

  target_groups = [
    {
      name_prefix      = "test"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}
