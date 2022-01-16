provider "aws" {
  region = local.region

  default_tags {
    tags = {
      Project = "terraform-aws-autoscaling"
    }
  }

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

locals {
  name   = "example-asg"
  region = "eu-west-1"

  tags = [
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
    {
      key                 = "foo"
      value               = "something"
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
  version = "~> 3.0"

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
  version = "~> 4.0"

  name        = local.name
  description = "A security group"
  vpc_id      = module.vpc.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb_http_sg.security_group_id
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
  version = "~> 4.0"

  name        = "${local.name}-alb-http"
  vpc_id      = module.vpc.vpc_id
  description = "Security group for ${local.name}"

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = local.tags_as_map
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = local.name

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.alb_http_sg.security_group_id]

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
# Configuration only
################################################################################

module "lt_only" {
  source = "../../"

  create_asg = false
  name       = "lt-only-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  # Launch template
  create_lt = true

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags        = local.tags
  tags_as_map = local.tags_as_map
}

module "lc_only" {
  source = "../../"

  create_asg = false
  name       = "lc-only-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  # Launch configuration
  create_lc = true

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags        = local.tags
  tags_as_map = local.tags_as_map
}

################################################################################
# Default
################################################################################

# Launch template
module "default_lt" {
  source = "../../"

  # Autoscaling group
  name = "default-lt-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  # Launch template
  use_lt    = true
  create_lt = true

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags        = local.tags
  tags_as_map = local.tags_as_map
}

# Launch configuration
module "default_lc" {
  source = "../../"

  # Autoscaling group
  name = "default-lc-${local.name}"

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

# Launch template
resource "aws_launch_template" "this" {
  name_prefix   = "external-lt-${local.name}-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  lifecycle {
    create_before_destroy = true
  }
}

module "external_lt" {
  source = "../../"

  # Autoscaling group
  name = "external-lt-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  # Launch template
  use_lt          = true
  launch_template = aws_launch_template.this.name

  tags        = local.tags
  tags_as_map = local.tags_as_map
}

# Launch configuration
resource "aws_launch_configuration" "this" {
  name_prefix   = "external-lc-${local.name}-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  lifecycle {
    create_before_destroy = true
  }
}

module "external_lc" {
  source = "../../"

  # Autoscaling group
  name = "external-lc-${local.name}"

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

# Launch template
module "complete_lt" {
  source = "../../"

  # Autoscaling group
  name            = "complete-lt-${local.name}"
  use_name_prefix = false
  instance_name   = "my-instance-name"

  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.vpc.private_subnets
  service_linked_role_arn   = aws_iam_service_linked_role.autoscaling.arn

  initial_lifecycle_hooks = [
    {
      name                 = "ExampleStartupLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 60
      lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "hello" = "world" })
    },
    {
      name                 = "ExampleTerminationLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 180
      lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "goodbye" = "world" })
    }
  ]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch template
  lt_name                = "complete-lt-${local.name}"
  description            = "Complete launch template example"
  update_default_version = true

  use_lt    = true
  create_lt = true

  image_id          = data.aws_ami.amazon_linux.id
  instance_type     = "t3.micro"
  user_data_base64  = base64encode(local.user_data)
  ebs_optimized     = true
  enable_monitoring = true

  iam_instance_profile_arn = aws_iam_instance_profile.ssm.arn
  # # Security group is set on the ENIs below
  # security_groups          = [module.asg_sg.security_group_id]

  target_group_arns = module.alb.target_group_arns

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 20
        volume_type           = "gp2"
      }
      }, {
      device_name = "/dev/sda1"
      no_device   = 1
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 30
        volume_type           = "gp2"
      }
    }
  ]

  capacity_reservation_specification = {
    capacity_reservation_preference = "open"
  }

  cpu_options = {
    core_count       = 1
    threads_per_core = 1
  }

  credit_specification = {
    cpu_credits = "standard"
  }

  # enclave_options = {
  #   enabled = true # Cannot enable hibernation and nitro enclaves on same instance nor on T3 instance type
  # }

  # hibernation_options = {
  #   configured = true # Root volume must be encrypted & not spot to enable hibernation
  # }

  instance_market_options = {
    market_type = "spot"
    spot_options = {
      block_duration_minutes = 60
    }
  }

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 32
    instance_metadata_tags      = "enabled"
  }

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = [module.asg_sg.security_group_id]
    },
    {
      delete_on_termination = true
      description           = "eth1"
      device_index          = 1
      security_groups       = [module.asg_sg.security_group_id]
    }
  ]

  placement = {
    availability_zone = "${local.region}b"
  }

  tag_specifications = [
    {
      resource_type = "instance"
      tags          = { WhatAmI = "Instance" }
    },
    {
      resource_type = "volume"
      tags          = merge({ WhatAmI = "Volume" }, local.tags_as_map)
    },
    {
      resource_type = "spot-instances-request"
      tags          = merge({ WhatAmI = "SpotInstanceRequest" }, local.tags_as_map)
    }
  ]

  tags        = local.tags
  tags_as_map = local.tags_as_map

  # Autoscaling Schedule
  schedules = {
    night = {
      min_size         = 0
      max_size         = 0
      desired_capacity = 0
      recurrence       = "0 18 * * 1-5" # Mon-Fri in the evening
      time_zone        = "Europe/Rome"
    }

    morning = {
      min_size         = 0
      max_size         = 1
      desired_capacity = 1
      recurrence       = "0 7 * * 1-5" # Mon-Fri in the morning
    }

    go-offline-to-celebrate-new-year = {
      min_size         = 0
      max_size         = 0
      desired_capacity = 0
      start_time       = "2031-12-31T10:00:00Z" # Should be in the future
      end_time         = "2032-01-01T16:00:00Z"
    }
  }
  # Target scaling policy schedule based on average CPU load
  scaling_policies = {
    avg-cpu-policy-greater-than-50 = {
      policy_type               = "TargetTrackingScaling"
      estimated_instance_warmup = 1200
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = 50.0
      }
    },
    predictive-scaling = {
      policy_type = "PredictiveScaling"
      predictive_scaling_config = {
        metric_specification = {
          target_value = 32
          predefined_scaling_metric_specification = {
            predefined_metric_type = "ASGAverageCPUUtilization"
            resource_label         = "testLabel"
          }
          predefined_load_metric_specification = {
            predefined_metric_type = "ASGTotalCPUUtilization"
            resource_label         = "testLabel"
          }
        }
        mode                         = "ForecastAndScale"
        scheduling_buffer_time       = 10
        max_capacity_breach_behavior = "IncreaseMaxCapacity"
        max_capacity_buffer          = 10
      }
    }
  }
}

# Launch configuration
module "complete_lc" {
  source = "../../"

  # Autoscaling group
  name            = "complete-lc-${local.name}"
  use_name_prefix = false
  instance_name   = "my-instance-name"

  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.vpc.private_subnets
  service_linked_role_arn   = aws_iam_service_linked_role.autoscaling.arn

  initial_lifecycle_hooks = [
    {
      name                 = "ExampleStartupLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 60
      lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "hello" = "world" })
    },
    {
      name                 = "ExampleTerminationLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 180
      lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "goodbye" = "world" })
    }
  ]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch configuration
  lc_name   = "complete-lc-${local.name}"
  use_lc    = true
  create_lc = true

  image_id          = data.aws_ami.amazon_linux.id
  instance_type     = "t3.micro"
  user_data         = local.user_data
  ebs_optimized     = true
  enable_monitoring = true

  iam_instance_profile_arn    = aws_iam_instance_profile.ssm.arn
  security_groups             = [module.asg_sg.security_group_id]
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

################################################################################
# Mixed instance policy
################################################################################

module "mixed_instance" {
  source = "../../"

  # Autoscaling group
  name = "mixed-instance-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 5
  desired_capacity    = 4

  image_id           = data.aws_ami.amazon_linux.id
  instance_type      = "t3.micro"
  capacity_rebalance = true

  initial_lifecycle_hooks = [
    {
      name                 = "ExampleStartupLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 60
      lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "hello" = "world" })
    },
    {
      name                 = "ExampleTerminationLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 180
      lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "goodbye" = "world" })
    }
  ]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch template
  create_lt              = true
  update_default_version = true

  # Mixed instances
  use_mixed_instances_policy = true
  mixed_instances_policy = {
    instances_distribution = {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 10
      spot_allocation_strategy                 = "capacity-optimized"
    }

    override = [
      {
        instance_type     = "t3.nano"
        weighted_capacity = "2"
      },
      {
        instance_type     = "t3.medium"
        weighted_capacity = "1"
      },
    ]
  }

  tags        = local.tags
  tags_as_map = local.tags_as_map
}

################################################################################
# With warm pool
################################################################################

module "warmed_lt" {
  source = "../../"

  # Autoscaling group
  name = "warmed-lt-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  # Launch template
  use_lt    = true
  create_lt = true

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  warm_pool = {
    pool_state                  = "Stopped"
    min_size                    = 1
    max_group_prepared_capacity = 2
  }

  tags        = local.tags
  tags_as_map = local.tags_as_map
}
