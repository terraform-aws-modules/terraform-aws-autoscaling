provider "aws" {
  region = "eu-west-1"

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["137112412989"] # Amazon

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

######
# Launch template and autoscaling group
######
module "example" {
  source = "../../"

  name = "example-with-ec2-lifecycle-hook"

  create_asg_with_initial_lifecycle_hook = true

  initial_lifecycle_hook_name                 = "ExampleLifeCycleHook"
  initial_lifecycle_hook_lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
  initial_lifecycle_hook_default_result       = "CONTINUE"

  # This could be a rendered data resource
  initial_lifecycle_hook_notification_metadata = <<EOF
{
  "foo": "bar"
}
EOF

  # Launch template
  #
  # launch_template = "my-existing-launch-template" # Use the existing launch template
  # create_lt = false # disables creation of launch template
  lt_name = "example-lt"

  image_id                     = data.aws_ami.amazon_linux.id
  instance_type                = "t2.micro"
  security_groups              = [data.aws_security_group.default.id]
  associate_public_ip_address  = true
  recreate_asg_when_lt_changes = true

  block_device_mappings = [
    {
      # Root block device
      device_name = "/dev/xvda"

      ebs = [
        {
          volume_type = "gp2"
          volume_size = 50
        },
      ]
    },
    {
      # EBS Block Device
      device_name = "/dev/xvdz"

      ebs = [
        {
          volume_type = "gp2"
          volume_size = 50
        },
      ]
    },
  ]

  # Auto scaling group
  asg_name                  = "example-asg"
  vpc_zone_identifier       = data.aws_subnet_ids.all.ids
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

  tags_as_map = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }
}
