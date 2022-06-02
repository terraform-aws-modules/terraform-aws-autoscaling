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
  name   = "ex-asg-complete"
  region = "eu-west-1"
  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  user_data = <<-EOT
  #!/bin/bash
  echo "Hello Terraform!"
  EOT
}

################################################################################
# Disabled
################################################################################

module "disabled" {
  source = "../../"

  create                 = false
  create_launch_template = false

  # Autoscaling group
  name = "disabled-${local.name}"
}

################################################################################
# Launch template only
################################################################################

module "launch_template_only" {
  source = "../../"

  create = false
  name   = "launch-template-only-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags = local.tags
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

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags = local.tags
}

################################################################################
# External
################################################################################

resource "aws_launch_template" "this" {
  name_prefix   = "external-lt-${local.name}-"
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

  # Launch template
  create_launch_template = false
  launch_template        = aws_launch_template.this.name

  tags = local.tags
}

################################################################################
# Complete
################################################################################

module "complete" {
  source = "../../"

  # Autoscaling group
  name            = "complete-${local.name}"
  use_name_prefix = false
  instance_name   = "my-instance-name"

  ignore_desired_capacity_changes = true

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
  launch_template_name        = "complete-${local.name}"
  launch_template_description = "Complete launch template example"
  update_default_version      = true

  image_id          = data.aws_ami.amazon_linux.id
  instance_type     = "t3.micro"
  user_data         = base64encode(local.user_data)
  ebs_optimized     = true
  enable_monitoring = true

  create_iam_instance_profile = true
  iam_role_name               = "complete-${local.name}"
  iam_role_path               = "/ec2/"
  iam_role_description        = "Complete IAM role example"
  iam_role_tags = {
    CustomIamRole = "Yes"
  }
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

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
  }

  maintenance_options = {
    auto_recovery = "default"
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
      tags          = merge({ WhatAmI = "Volume" })
    },
    {
      resource_type = "spot-instances-request"
      tags          = merge({ WhatAmI = "SpotInstanceRequest" })
    }
  ]

  tags = local.tags

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
      predictive_scaling_configuration = {
        mode                         = "ForecastAndScale"
        scheduling_buffer_time       = 10
        max_capacity_breach_behavior = "IncreaseMaxCapacity"
        max_capacity_buffer          = 10
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
      }
    }
    request-count-per-target = {
      policy_type               = "TargetTrackingScaling"
      estimated_instance_warmup = 120
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ALBRequestCountPerTarget"
          resource_label         = "${module.alb.lb_arn_suffix}/${module.alb.target_group_arn_suffixes[0]}"
        }
        target_value = 800
      }
    }
  }
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

  iam_instance_profile_arn = aws_iam_instance_profile.ssm.arn

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

  tags = local.tags
}

################################################################################
# With warm pool
################################################################################

module "warm_pool" {
  source = "../../"

  # Autoscaling group
  name = "warm-pool-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  warm_pool = {
    pool_state                  = "Stopped"
    min_size                    = 1
    max_group_prepared_capacity = 2
  }

  capacity_reservation_specification = {
    capacity_reservation_target = {
      capacity_reservation_id = aws_ec2_capacity_reservation.targeted.id
    }
  }

  tags = local.tags
}

################################################################################
# EFA Network Interface
# !Warning - This example requires the use of expensive instance types - Warning!
################################################################################

locals {
  efa_user_data = <<-EOT
  # Install EFA libraries
  curl -O https://efa-installer.amazonaws.com/aws-efa-installer-latest.tar.gz
  tar -xf aws-efa-installer-latest.tar.gz && cd aws-efa-installer
  ./efa_installer.sh -y --minimal
  fi_info -p efa -t FI_EP_RDM
  # Disable ptrace
  sysctl -w kernel.yama.ptrace_scope=0
  EOT
}

module "efa" {
  source = "../../"

  # Autoscaling group
  name = "default-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1

  # aws ec2 describe-instance-types --region eu-west-1 --filters Name=network-info.efa-supported,Values=true --query "InstanceTypes[*].[InstanceType]" --output text | sort
  instance_type = "c5n.9xlarge"
  image_id      = data.aws_ami.amazon_linux.id
  user_data     = base64encode(local.efa_user_data)

  network_interfaces = [
    {
      description                 = "EFA interface example"
      delete_on_termination       = true
      device_index                = 0
      associate_public_ip_address = false
      interface_type              = "efa"
    }
  ]

  tags = local.tags
}


################################################################################
# Instance Requirements
################################################################################

module "instance_requirements" {
  source = "../../"

  # TODO - needs https://github.com/hashicorp/terraform-provider-aws/issues/21566 for ASG
  create = false

  # Autoscaling group
  name = "instance-req-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 5
  desired_capacity    = 1

  update_default_version = true
  image_id               = data.aws_ami.amazon_linux.id

  use_mixed_instances_policy = true
  instance_requirements = {

    accelerator_manufacturers = []
    accelerator_names         = []
    accelerator_types         = []

    baseline_ebs_bandwidth_mbps = {
      min = 400
      max = 1600
    }

    burstable_performance   = "excluded"
    cpu_manufacturers       = ["amazon-web-services", "amd", "intel"]
    excluded_instance_types = ["t*"]
    instance_generations    = ["current"]
    local_storage_types     = ["ssd", "hdd"]

    memory_gib_per_vcpu = {
      min = 4
      max = 16
    }

    memory_mib = {
      min = 24
      max = 128
    }

    network_interface_count = {
      min = 1
      max = 16
    }

    vcpu_count = {
      min = 2
      max = 96
    }
  }

  tags = local.tags
}

################################################################################
# Instance Requirements - Accelerators
################################################################################

module "instance_requirements_accelerators" {
  source = "../../"

  # TODO - needs https://github.com/hashicorp/terraform-provider-aws/issues/21566 for ASG
  # Requires access to g or p instance types in your account http://aws.amazon.com/contact-us/ec2-request
  create = false

  # Autoscaling group
  name = "instance-req-accelerators-${local.name}"

  vpc_zone_identifier = module.vpc.private_subnets
  min_size            = 0
  max_size            = 5
  desired_capacity    = 1

  update_default_version = true
  image_id               = data.aws_ami.amazon_linux.id

  use_mixed_instances_policy = true
  instance_requirements = {
    accelerator_count = {
      min = 1
      max = 8
    }

    accelerator_manufacturers = ["amazon-web-services", "amd", "nvidia"]
    accelerator_names         = ["a100", "v100", "k80", "t4", "m60", "radeon-pro-v520"]

    # accelerator_total_memory_mib = {
    #   min = 4096
    #   max = 16384
    # }

    accelerator_types = ["gpu", "inference"]
    bare_metal        = "excluded"

    # baseline_ebs_bandwidth_mbps = {
    #   min = 400
    #   max = 16384
    # }

    burstable_performance   = "excluded"
    cpu_manufacturers       = ["amazon-web-services", "amd", "intel"]
    excluded_instance_types = ["t*"]
    instance_generations    = ["current"]
    local_storage_types     = ["ssd", "hdd"]

    # memory_gib_per_vcpu = {
    #   min = 4
    #   max = 16
    # }

    memory_mib = {
      min = 24
      max = 99999 # seems to be a provider bug
    }

    # network_interface_count = {
    #   min = 1
    #   max =4
    # }

    vcpu_count = {
      min = 2
      max = 999 # seems to be a provider bug
    }
  }

  tags = local.tags
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

  tags = local.tags
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

  tags = local.tags
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
  tags = local.tags
}

resource "aws_iam_role" "ssm" {
  name = "complete-${local.name}"
  tags = local.tags

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

module "alb_http_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "~> 4.0"

  name        = "${local.name}-alb-http"
  vpc_id      = module.vpc.vpc_id
  description = "Security group for ${local.name}"

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = local.tags
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

  tags = local.tags
}

resource "aws_ec2_capacity_reservation" "targeted" {
  instance_type           = "t3.micro"
  instance_platform       = "Linux/UNIX"
  availability_zone       = "${local.region}a"
  instance_count          = 1
  instance_match_criteria = "targeted"
}
