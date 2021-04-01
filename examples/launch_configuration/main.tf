provider "aws" {
  region = local.region

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

locals {
  name   = "example-launch-config"
  region = "eu-west-1"

  tags = [
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
    {
      key                 = "foo"
      value               = ""
      propagate_at_launch = true
    },
  ]

  tags_as_map = {
    Owner       = "user"
    Environment = "dev"
  }

  user_data = <<-EOT
  #!/bin/bash
  echo "Hello Terraform!"
  EOT
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2"

  name = local.name
  cidr = "10.99.0.0/18"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets  = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
  private_subnets = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags_as_map
}

module "asg_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3"

  name        = local.name
  description = "A security group"
  vpc_id      = module.vpc.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb_http_sg.this_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_rules = ["all-all"]

  tags = local.tags_as_map
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
  custom_suffix    = local.name

  # Sometimes good sleep is required to have some IAM resources created before they can be used
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

resource "aws_iam_instance_profile" "ssm" {
  name = "complete-${local.name}"
  role = aws_iam_role.ssm.name
  tags = local.tags_as_map
}

resource "aws_iam_role" "ssm" {
  name = "complete-${local.name}"
  tags = local.tags_as_map

  assume_role_policy = <<-EOT
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOT
}

module "alb_http_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "~> 3"

  name        = "${local.name}-alb-http"
  vpc_id      = module.vpc.vpc_id
  description = "Security group for ${local.name}"

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = local.tags_as_map
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5"

  name = local.name

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.alb_http_sg.this_security_group_id]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name             = local.name
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    },
  ]

  tags = local.tags_as_map
}

################################################################################
# Disabled
################################################################################

module "disabled" {
  source = "../../"

  create_asg = false

  # Autoscaling group
  name = "disabled-${local.name}"
}

################################################################################
# Default
################################################################################

module "default" {
  source = "../../"

  # Autoscaling group
  name = "default-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  # Launch configuration
  use_lc    = true
  create_lc = true

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags        = local.tags
  tags_as_map = local.tags_as_map
}

################################################################################
# External
################################################################################

resource "aws_launch_configuration" "this" {
  name_prefix   = "external-${local.name}-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  lifecycle {
    create_before_destroy = true
  }
}

module "external" {
  source = "../../"

  # Autoscaling group
  name = "external-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  # Launch config
  use_lc               = true
  launch_configuration = aws_launch_configuration.this.name

  tags        = local.tags
  tags_as_map = local.tags_as_map
}

################################################################################
# Complete
################################################################################

module "complete" {
  source = "../../"

  # Autoscaling group
  name            = "complete-${local.name}"
  use_name_prefix = false

  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.vpc.private_subnets
  service_linked_role_arn   = aws_iam_service_linked_role.autoscaling.arn

  # Launch configuration
  lc_name   = "complete-${local.name}"
  use_lc    = true
  create_lc = true

  image_id          = data.aws_ami.amazon_linux.id
  instance_type     = "t3.micro"
  user_data         = local.user_data
  ebs_optimized     = true
  enable_monitoring = true

  iam_instance_profile_arn    = aws_iam_instance_profile.ssm.arn
  security_groups             = [module.asg_sg.this_security_group_id]
  associate_public_ip_address = true

  spot_price        = "0.014"
  target_group_arns = module.alb.target_group_arns

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      delete_on_termination = true
      encrypted             = true
      volume_type           = "gp2"
      volume_size           = "50"
    },
  ]

  root_block_device = [
    {
      delete_on_termination = true
      encrypted             = true
      volume_size           = "50"
      volume_type           = "gp2"
    },
  ]

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 32
  }

  tags        = local.tags
  tags_as_map = local.tags_as_map
}
