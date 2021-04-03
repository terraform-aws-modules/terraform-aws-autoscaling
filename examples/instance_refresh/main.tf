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
  name   = "example-instance-refresh"
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

################################################################################
# Launch configuration
################################################################################

module "launch_configuration" {
  source = "../../"

  # Autoscaling group
  name = "lc-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch configuration
  use_lc    = true
  create_lc = true

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags        = local.tags
  tags_as_map = local.tags_as_map
}

################################################################################
# Launch template
################################################################################

module "launch_template" {
  source = "../../"

  # Autoscaling group
  name = "lt-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch template
  use_lt    = true
  create_lt = true

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags        = local.tags
  tags_as_map = local.tags_as_map
}
