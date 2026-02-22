# AWS Auto Scaling Group (ASG) Terraform module

Terraform module which creates Auto Scaling resources on AWS.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Available Features

- Autoscaling group with launch template - either created by the module or utilizing an existing launch template
- Autoscaling group utilizing mixed instances policy
- Ability to configure autoscaling groups to set instance refresh configuration and add lifecycle hooks
- Ability to create an autoscaling group that respects `desired_capacity` or one that ignores to allow for scaling without conflicting Terraform diffs
- IAM role and instance profile creation

## Usage

```hcl
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "example-asg"

  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = ["subnet-1235678", "subnet-87654321"]

  initial_lifecycle_hooks = [
    {
      name                  = "ExampleStartupLifeCycleHook"
      default_result        = "CONTINUE"
      heartbeat_timeout     = 60
      lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
      notification_metadata = jsonencode({ "hello" = "world" })
    },
    {
      name                  = "ExampleTerminationLifeCycleHook"
      default_result        = "CONTINUE"
      heartbeat_timeout     = 180
      lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
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
      max_healthy_percentage = 100
    }
    triggers = ["tag"]
  }

  # Launch template
  launch_template_name        = "example-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true

  image_id          = "ami-ebd02392"
  instance_type     = "t3.micro"
  ebs_optimized     = true
  enable_monitoring = true

  # IAM role & instance profile
  create_iam_instance_profile = true
  iam_role_name               = "example-asg"
  iam_role_path               = "/ec2/"
  iam_role_description        = "IAM role example"
  iam_role_tags = {
    CustomIamRole = "Yes"
  }
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

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

  instance_market_options = {
    market_type = "spot"
    spot_options = {
      block_duration_minutes = 60
    }
  }

  # This will ensure imdsv2 is enabled, required, and a single hop which is aws security
  # best practices
  # See https://docs.aws.amazon.com/securityhub/latest/userguide/autoscaling-controls.html#autoscaling-4
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = ["sg-12345678"]
    },
    {
      delete_on_termination = true
      description           = "eth1"
      device_index          = 1
      security_groups       = ["sg-12345678"]
    }
  ]

  placement = {
    availability_zone = "us-west-1b"
  }

  tag_specifications = [
    {
      resource_type = "instance"
      tags          = { WhatAmI = "Instance" }
    },
    {
      resource_type = "volume"
      tags          = { WhatAmI = "Volume" }
    },
    {
      resource_type = "spot-instances-request"
      tags          = { WhatAmI = "SpotInstanceRequest" }
    }
  ]

  tags = {
    Environment = "dev"
    Project     = "megasecret"
  }
}
```

## Conditional creation

The following combinations are supported to conditionally create resources and/or use externally created resources within the module:

Note: the default behavior of the module is to create an autoscaling group and launch template.

- Disable resource creation (no resources created):

```hcl
  create                 = false
  create_launch_template = false
```

- Create only a launch template:

```hcl
  create = false
```

- Create an autoscaling group using an externally created launch template:

```hcl
  create_launch_template = false
  launch_template        = aws_launch_template.my_launch_template.name
```

- Create an autoscaling group with a mixed instance policy:

```hcl
  use_mixed_instances_policy = true
```

- Create the autoscaling policies:

```hcl
  scaling_policies = {
    my-policy = {
      policy_type               = "TargetTrackingScaling"
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ASGAverageCPUUtilization"
          resource_label         = "MyLabel"
        }
        target_value = 50.0
      }
    }
  }
```

## Examples

- [Complete](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/complete) - Creates several variations of resources for autoscaling groups and launch templates.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.33 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.idc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_schedule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_autoscaling_traffic_source_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_traffic_source_attachment) | resource |
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling_group_tags"></a> [autoscaling\_group\_tags](#input\_autoscaling\_group\_tags) | A map of additional tags to add to the autoscaling group | `map(string)` | `{}` | no |
| <a name="input_autoscaling_group_tags_not_propagate_at_launch"></a> [autoscaling\_group\_tags\_not\_propagate\_at\_launch](#input\_autoscaling\_group\_tags\_not\_propagate\_at\_launch) | A list of tag keys that should NOT be propagated to launched EC2 instances | `list(string)` | `[]` | no |
| <a name="input_availability_zone_distribution"></a> [availability\_zone\_distribution](#input\_availability\_zone\_distribution) | A map of configuration for capacity distribution across availability zones | <pre>object({<br/>    capacity_distribution_strategy = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | A list of Availability Zones where instances in the Auto Scaling group can be created. Used for launching into the default VPC subnet in each Availability Zone when not using the `vpc_zone_identifier` attribute, or for attaching a network interface when an existing network interface ID is specified in a launch template. Conflicts with `vpc_zone_identifier` | `list(string)` | `null` | no |
| <a name="input_block_device_mappings"></a> [block\_device\_mappings](#input\_block\_device\_mappings) | Specify volumes to attach to the instance besides the volumes specified by the AMI | <pre>list(object({<br/>    device_name = optional(string)<br/>    ebs = optional(object({<br/>      delete_on_termination      = optional(bool)<br/>      encrypted                  = optional(bool)<br/>      iops                       = optional(number)<br/>      kms_key_id                 = optional(string)<br/>      snapshot_id                = optional(string)<br/>      throughput                 = optional(number)<br/>      volume_initialization_rate = optional(number)<br/>      volume_size                = optional(number)<br/>      volume_type                = optional(string)<br/>    }))<br/>    no_device    = optional(string)<br/>    virtual_name = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_capacity_rebalance"></a> [capacity\_rebalance](#input\_capacity\_rebalance) | Indicates whether capacity rebalance is enabled | `bool` | `null` | no |
| <a name="input_capacity_reservation_specification"></a> [capacity\_reservation\_specification](#input\_capacity\_reservation\_specification) | Targeting for EC2 capacity reservations | <pre>object({<br/>    capacity_reservation_preference = optional(string)<br/>    capacity_reservation_target = optional(object({<br/>      capacity_reservation_id                 = optional(string)<br/>      capacity_reservation_resource_group_arn = optional(string)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_context"></a> [context](#input\_context) | Reserved | `string` | `null` | no |
| <a name="input_cpu_options"></a> [cpu\_options](#input\_cpu\_options) | The CPU options for the instance | <pre>object({<br/>    amd_sev_snp           = optional(string)<br/>    core_count            = optional(number)<br/>    nested_virtualization = optional(string)<br/>    threads_per_core      = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether to create autoscaling group or not | `bool` | `true` | no |
| <a name="input_create_iam_instance_profile"></a> [create\_iam\_instance\_profile](#input\_create\_iam\_instance\_profile) | Determines whether an IAM instance profile is created or to use an existing IAM instance profile | `bool` | `false` | no |
| <a name="input_create_launch_template"></a> [create\_launch\_template](#input\_create\_launch\_template) | Determines whether to create launch template or not | `bool` | `true` | no |
| <a name="input_credit_specification"></a> [credit\_specification](#input\_credit\_specification) | Customize the credit specification of the instance | <pre>object({<br/>    cpu_credits = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_default_cooldown"></a> [default\_cooldown](#input\_default\_cooldown) | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start | `number` | `null` | no |
| <a name="input_default_instance_warmup"></a> [default\_instance\_warmup](#input\_default\_instance\_warmup) | Amount of time, in seconds, until a newly launched instance can contribute to the Amazon CloudWatch metrics. This delay lets an instance finish initializing before Amazon EC2 Auto Scaling aggregates instance metrics, resulting in more reliable usage data. Set this value equal to the amount of time that it takes for resource consumption to become stable after an instance reaches the InService state. | `number` | `null` | no |
| <a name="input_default_version"></a> [default\_version](#input\_default\_version) | Default Version of the launch template | `string` | `null` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the autoscaling group | `number` | `null` | no |
| <a name="input_desired_capacity_type"></a> [desired\_capacity\_type](#input\_desired\_capacity\_type) | The unit of measurement for the value specified for desired\_capacity. Supported for attribute-based instance type selection only. Valid values: `units`, `vcpu`, `memory-mib`. | `string` | `null` | no |
| <a name="input_disable_api_stop"></a> [disable\_api\_stop](#input\_disable\_api\_stop) | If true, enables EC2 instance stop protection | `bool` | `null` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | If true, enables EC2 instance termination protection | `bool` | `null` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `null` | no |
| <a name="input_enable_monitoring"></a> [enable\_monitoring](#input\_enable\_monitoring) | Enables/disables detailed monitoring | `bool` | `true` | no |
| <a name="input_enabled_metrics"></a> [enabled\_metrics](#input\_enabled\_metrics) | A list of metrics to collect. The allowed values are `GroupDesiredCapacity`, `GroupInServiceCapacity`, `GroupPendingCapacity`, `GroupMinSize`, `GroupMaxSize`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupStandbyCapacity`, `GroupTerminatingCapacity`, `GroupTerminatingInstances`, `GroupTotalCapacity`, `GroupTotalInstances` | `list(string)` | `[]` | no |
| <a name="input_enclave_options"></a> [enclave\_options](#input\_enclave\_options) | Enable Nitro Enclaves on launched instances | <pre>object({<br/>    enabled = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate. You can force an Auto Scaling Group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling | `bool` | `null` | no |
| <a name="input_force_delete_warm_pool"></a> [force\_delete\_warm\_pool](#input\_force\_delete\_warm\_pool) | Allows deleting the Auto Scaling Group without waiting for all instances in the warm pool to terminate | `bool` | `null` | no |
| <a name="input_health_check_grace_period"></a> [health\_check\_grace\_period](#input\_health\_check\_grace\_period) | Time (in seconds) after instance comes into service before checking health | `number` | `null` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | `EC2` or `ELB`. Controls how health checking is done | `string` | `null` | no |
| <a name="input_hibernation_options"></a> [hibernation\_options](#input\_hibernation\_options) | The hibernation options for the instance | <pre>object({<br/>    configured = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_iam_instance_profile_arn"></a> [iam\_instance\_profile\_arn](#input\_iam\_instance\_profile\_arn) | Amazon Resource Name (ARN) of an existing IAM instance profile. Used when `create_iam_instance_profile` = `false` | `string` | `null` | no |
| <a name="input_iam_instance_profile_name"></a> [iam\_instance\_profile\_name](#input\_iam\_instance\_profile\_name) | The name of the IAM instance profile to be created (`create_iam_instance_profile` = `true`) or existing (`create_iam_instance_profile` = `false`) | `string` | `null` | no |
| <a name="input_iam_role_description"></a> [iam\_role\_description](#input\_iam\_role\_description) | Description of the role | `string` | `null` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Name to use on IAM role created | `string` | `null` | no |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path) | IAM role path | `string` | `null` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the IAM role | `string` | `null` | no |
| <a name="input_iam_role_policies"></a> [iam\_role\_policies](#input\_iam\_role\_policies) | IAM policies to attach to the IAM role | `map(string)` | `{}` | no |
| <a name="input_iam_role_tags"></a> [iam\_role\_tags](#input\_iam\_role\_tags) | A map of additional tags to add to the IAM role created | `map(string)` | `{}` | no |
| <a name="input_iam_role_use_name_prefix"></a> [iam\_role\_use\_name\_prefix](#input\_iam\_role\_use\_name\_prefix) | Determines whether the IAM role name (`iam_role_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_ignore_desired_capacity_changes"></a> [ignore\_desired\_capacity\_changes](#input\_ignore\_desired\_capacity\_changes) | Determines whether the `desired_capacity` value is ignored after initial apply. See README note for more details | `bool` | `false` | no |
| <a name="input_ignore_failed_scaling_activities"></a> [ignore\_failed\_scaling\_activities](#input\_ignore\_failed\_scaling\_activities) | Whether to ignore failed Auto Scaling scaling activities while waiting for capacity. The default is false -- failed scaling activities cause errors to be returned. | `bool` | `false` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The AMI from which to launch the instance | `string` | `null` | no |
| <a name="input_initial_lifecycle_hooks"></a> [initial\_lifecycle\_hooks](#input\_initial\_lifecycle\_hooks) | One or more Lifecycle Hooks to attach to the Auto Scaling Group before instances are launched. The syntax is exactly the same as the separate `aws_autoscaling_lifecycle_hook` resource, without the `autoscaling_group_name` attribute. Please note that this will only work when creating a new Auto Scaling Group. For all other use-cases, please use `aws_autoscaling_lifecycle_hook` resource | <pre>list(object({<br/>    default_result          = optional(string)<br/>    heartbeat_timeout       = optional(number)<br/>    lifecycle_transition    = string<br/>    name                    = string<br/>    notification_metadata   = optional(string)<br/>    notification_target_arn = optional(string)<br/>    role_arn                = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_instance_initiated_shutdown_behavior"></a> [instance\_initiated\_shutdown\_behavior](#input\_instance\_initiated\_shutdown\_behavior) | Shutdown behavior for the instance. Can be `stop` or `terminate`. (Default: `stop`) | `string` | `null` | no |
| <a name="input_instance_maintenance_policy"></a> [instance\_maintenance\_policy](#input\_instance\_maintenance\_policy) | If this block is configured, add a instance maintenance policy to the specified Auto Scaling group | <pre>object({<br/>    max_healthy_percentage = number<br/>    min_healthy_percentage = number<br/>  })</pre> | `null` | no |
| <a name="input_instance_market_options"></a> [instance\_market\_options](#input\_instance\_market\_options) | The market (purchasing) option for the instance | <pre>object({<br/>    market_type = optional(string)<br/>    spot_options = optional(object({<br/>      block_duration_minutes         = optional(number)<br/>      instance_interruption_behavior = optional(string)<br/>      max_price                      = optional(string)<br/>      spot_instance_type             = optional(string)<br/>      valid_until                    = optional(string)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name that is propogated to launched EC2 instances via a tag - if not provided, defaults to `var.name` | `string` | `""` | no |
| <a name="input_instance_refresh"></a> [instance\_refresh](#input\_instance\_refresh) | If this block is configured, start an Instance Refresh when this Auto Scaling Group is updated | <pre>object({<br/>    preferences = optional(object({<br/>      alarm_specification = optional(object({<br/>        alarms = optional(list(string))<br/>      }))<br/>      auto_rollback                = optional(bool)<br/>      checkpoint_delay             = optional(number)<br/>      checkpoint_percentages       = optional(list(number))<br/>      instance_warmup              = optional(number)<br/>      max_healthy_percentage       = optional(number)<br/>      min_healthy_percentage       = optional(number)<br/>      scale_in_protected_instances = optional(string)<br/>      skip_matching                = optional(bool)<br/>      standby_instances            = optional(string)<br/>    }))<br/>    strategy = string<br/>    triggers = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_instance_requirements"></a> [instance\_requirements](#input\_instance\_requirements) | The attribute requirements for the type of instance. If present then `instance_type` cannot be present | <pre>object({<br/>    accelerator_count = optional(object({<br/>      max = optional(number)<br/>      min = optional(number)<br/>    }))<br/>    accelerator_manufacturers = optional(list(string))<br/>    accelerator_names         = optional(list(string))<br/>    accelerator_total_memory_mib = optional(object({<br/>      max = optional(number)<br/>      min = optional(number)<br/>    }))<br/>    accelerator_types      = optional(list(string))<br/>    allowed_instance_types = optional(list(string))<br/>    bare_metal             = optional(string)<br/>    baseline_ebs_bandwidth_mbps = optional(object({<br/>      max = optional(number)<br/>      min = optional(number)<br/>    }))<br/>    burstable_performance                                   = optional(string)<br/>    cpu_manufacturers                                       = optional(list(string))<br/>    excluded_instance_types                                 = optional(list(string))<br/>    instance_generations                                    = optional(list(string))<br/>    local_storage                                           = optional(string)<br/>    local_storage_types                                     = optional(list(string))<br/>    max_spot_price_as_percentage_of_optimal_on_demand_price = optional(number)<br/>    memory_gib_per_vcpu = optional(object({<br/>      max = optional(number)<br/>      min = optional(number)<br/>    }))<br/>    memory_mib = optional(object({<br/>      max = optional(number)<br/>      min = optional(number)<br/>    }))<br/>    network_bandwidth_gbps = optional(object({<br/>      max = optional(number)<br/>      min = optional(number)<br/>    }))<br/>    network_interface_count = optional(object({<br/>      max = optional(number)<br/>      min = optional(number)<br/>    }))<br/>    on_demand_max_price_percentage_over_lowest_price = optional(number)<br/>    require_hibernate_support                        = optional(bool)<br/>    spot_max_price_percentage_over_lowest_price      = optional(number)<br/>    total_local_storage_gb = optional(object({<br/>      max = optional(number)<br/>      min = optional(number)<br/>    }))<br/>    vcpu_count = optional(object({<br/>      max = optional(number)<br/>      min = string<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance. If present then `instance_requirements` cannot be present | `string` | `null` | no |
| <a name="input_kernel_id"></a> [kernel\_id](#input\_kernel\_id) | The kernel ID | `string` | `null` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The key name that should be used for the instance | `string` | `null` | no |
| <a name="input_launch_template_description"></a> [launch\_template\_description](#input\_launch\_template\_description) | Description of the launch template | `string` | `null` | no |
| <a name="input_launch_template_id"></a> [launch\_template\_id](#input\_launch\_template\_id) | ID of an existing launch template to be used (created outside of this module) | `string` | `null` | no |
| <a name="input_launch_template_name"></a> [launch\_template\_name](#input\_launch\_template\_name) | Name of launch template to be created | `string` | `""` | no |
| <a name="input_launch_template_tags"></a> [launch\_template\_tags](#input\_launch\_template\_tags) | A map of additional tags to add to the launch template | `map(string)` | `{}` | no |
| <a name="input_launch_template_use_name_prefix"></a> [launch\_template\_use\_name\_prefix](#input\_launch\_template\_use\_name\_prefix) | Determines whether to use `launch_template_name` as is or create a unique name beginning with the `launch_template_name` as the prefix | `bool` | `true` | no |
| <a name="input_launch_template_version"></a> [launch\_template\_version](#input\_launch\_template\_version) | Launch template version. Can be version number, `$Latest`, or `$Default` | `string` | `null` | no |
| <a name="input_license_specifications"></a> [license\_specifications](#input\_license\_specifications) | A list of license specifications to associate with | <pre>list(object({<br/>    license_configuration_arn = string<br/>  }))</pre> | `null` | no |
| <a name="input_maintenance_options"></a> [maintenance\_options](#input\_maintenance\_options) | The maintenance options for the instance | <pre>object({<br/>    auto_recovery = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_max_instance_lifetime"></a> [max\_instance\_lifetime](#input\_max\_instance\_lifetime) | The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 86400 and 31536000 seconds | `number` | `null` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the autoscaling group | `number` | `null` | no |
| <a name="input_metadata_options"></a> [metadata\_options](#input\_metadata\_options) | Customize the metadata options for the instance | <pre>object({<br/>    http_endpoint               = optional(string, "enabled")<br/>    http_protocol_ipv6          = optional(string)<br/>    http_put_response_hop_limit = optional(number, 1)<br/>    http_tokens                 = optional(string, "required")<br/>    instance_metadata_tags      = optional(string)<br/>  })</pre> | <pre>{<br/>  "http_endpoint": "enabled",<br/>  "http_put_response_hop_limit": 1,<br/>  "http_tokens": "required"<br/>}</pre> | no |
| <a name="input_metrics_granularity"></a> [metrics\_granularity](#input\_metrics\_granularity) | The granularity to associate with the metrics to collect. The only valid value is `1Minute` | `string` | `null` | no |
| <a name="input_min_elb_capacity"></a> [min\_elb\_capacity](#input\_min\_elb\_capacity) | Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes | `number` | `null` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the autoscaling group | `number` | `null` | no |
| <a name="input_mixed_instances_policy"></a> [mixed\_instances\_policy](#input\_mixed\_instances\_policy) | Configuration block containing settings to define launch targets for Auto Scaling groups | <pre>object({<br/>    instances_distribution = optional(object({<br/>      on_demand_allocation_strategy            = optional(string)<br/>      on_demand_base_capacity                  = optional(number)<br/>      on_demand_percentage_above_base_capacity = optional(number)<br/>      spot_allocation_strategy                 = optional(string)<br/>      spot_instance_pools                      = optional(number)<br/>      spot_max_price                           = optional(string)<br/>    }))<br/>    launch_template = object({<br/>      override = optional(list(object({<br/>        instance_requirements = optional(object({<br/>          accelerator_count = optional(object({<br/>            max = optional(number)<br/>            min = optional(number)<br/>          }))<br/>          accelerator_manufacturers = optional(list(string))<br/>          accelerator_names         = optional(list(string))<br/>          accelerator_total_memory_mib = optional(object({<br/>            max = optional(number)<br/>            min = optional(number)<br/>          }))<br/>          accelerator_types      = optional(list(string))<br/>          allowed_instance_types = optional(list(string))<br/>          bare_metal             = optional(string)<br/>          baseline_ebs_bandwidth_mbps = optional(object({<br/>            max = optional(number)<br/>            min = optional(number)<br/>          }))<br/>          burstable_performance                                   = optional(string)<br/>          cpu_manufacturers                                       = optional(list(string))<br/>          excluded_instance_types                                 = optional(list(string))<br/>          instance_generations                                    = optional(list(string))<br/>          local_storage                                           = optional(string)<br/>          local_storage_types                                     = optional(list(string))<br/>          max_spot_price_as_percentage_of_optimal_on_demand_price = optional(number)<br/>          memory_gib_per_vcpu = optional(object({<br/>            max = optional(number)<br/>            min = optional(number)<br/>          }))<br/>          memory_mib = optional(object({<br/>            max = optional(number)<br/>            min = optional(number)<br/>          }))<br/>          network_bandwidth_gbps = optional(object({<br/>            max = optional(number)<br/>            min = optional(number)<br/>          }))<br/>          network_interface_count = optional(object({<br/>            max = optional(number)<br/>            min = optional(number)<br/>          }))<br/>          on_demand_max_price_percentage_over_lowest_price = optional(number)<br/>          require_hibernate_support                        = optional(bool)<br/>          spot_max_price_percentage_over_lowest_price      = optional(number)<br/>          total_local_storage_gb = optional(object({<br/>            max = optional(number)<br/>            min = optional(number)<br/>          }))<br/>          vcpu_count = optional(object({<br/>            max = optional(number)<br/>            min = optional(number)<br/>          }))<br/>        }))<br/>        instance_type = optional(string)<br/>        launch_template_specification = optional(object({<br/>          launch_template_id   = optional(string)<br/>          launch_template_name = optional(string)<br/>          version              = optional(string)<br/>        }))<br/>        weighted_capacity = optional(string)<br/>      })))<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name used across the resources created | `string` | n/a | yes |
| <a name="input_network_interfaces"></a> [network\_interfaces](#input\_network\_interfaces) | Customize network interfaces to be attached at instance boot time | <pre>list(object({<br/>    associate_carrier_ip_address = optional(bool)<br/>    associate_public_ip_address  = optional(bool)<br/>    connection_tracking_specification = optional(object({<br/>      tcp_established_timeout = optional(number)<br/>      udp_stream_timeout      = optional(number)<br/>      udp_timeout             = optional(number)<br/>    }))<br/>    delete_on_termination = optional(bool)<br/>    description           = optional(string)<br/>    device_index          = optional(number)<br/>    ena_srd_specification = optional(object({<br/>      ena_srd_enabled = optional(bool)<br/>      ena_srd_udp_specification = optional(object({<br/>        ena_srd_udp_enabled = optional(bool)<br/>      }))<br/>    }))<br/>    interface_type       = optional(string)<br/>    ipv4_address_count   = optional(number)<br/>    ipv4_addresses       = optional(list(string))<br/>    ipv4_prefix_count    = optional(number)<br/>    ipv4_prefixes        = optional(list(string))<br/>    ipv6_address_count   = optional(number)<br/>    ipv6_addresses       = optional(list(string))<br/>    ipv6_prefix_count    = optional(number)<br/>    ipv6_prefixes        = optional(list(string))<br/>    network_card_index   = optional(number)<br/>    network_interface_id = optional(string)<br/>    primary_ipv6         = optional(bool)<br/>    private_ip_address   = optional(string)<br/>    security_groups      = optional(list(string), [])<br/>    subnet_id            = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_network_performance_options"></a> [network\_performance\_options](#input\_network\_performance\_options) | The network performance options for the launch template | <pre>object({<br/>    bandwidth_weighting = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_placement"></a> [placement](#input\_placement) | The placement of the instance | <pre>object({<br/>    affinity                = optional(string)<br/>    availability_zone       = optional(string)<br/>    group_id                = optional(string)<br/>    group_name              = optional(string)<br/>    host_id                 = optional(string)<br/>    host_resource_group_arn = optional(string)<br/>    partition_number        = optional(number)<br/>    spread_domain           = optional(string)<br/>    tenancy                 = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_placement_group"></a> [placement\_group](#input\_placement\_group) | The name of the placement group into which you'll launch your instances, if any | `string` | `null` | no |
| <a name="input_private_dns_name_options"></a> [private\_dns\_name\_options](#input\_private\_dns\_name\_options) | The options for the instance hostname. The default values are inherited from the subnet | <pre>object({<br/>    enable_resource_name_dns_aaaa_record = optional(bool)<br/>    enable_resource_name_dns_a_record    = optional(bool)<br/>    hostname_type                        = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_protect_from_scale_in"></a> [protect\_from\_scale\_in](#input\_protect\_from\_scale\_in) | Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events. | `bool` | `false` | no |
| <a name="input_putin_khuylo"></a> [putin\_khuylo](#input\_putin\_khuylo) | Do you agree that Putin doesn't respect Ukrainian sovereignty and territorial integrity? More info: https://en.wikipedia.org/wiki/Putin_khuylo! | `bool` | `true` | no |
| <a name="input_ram_disk_id"></a> [ram\_disk\_id](#input\_ram\_disk\_id) | The ID of the ram disk | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration | `string` | `null` | no |
| <a name="input_scaling_policies"></a> [scaling\_policies](#input\_scaling\_policies) | Map of target scaling policy schedule to create | <pre>map(object({<br/>    adjustment_type           = optional(string)<br/>    cooldown                  = optional(number)<br/>    enabled                   = optional(bool)<br/>    estimated_instance_warmup = optional(number)<br/>    metric_aggregation_type   = optional(string)<br/>    min_adjustment_magnitude  = optional(number)<br/>    name                      = optional(string) # Will fall back to the map key if not provided<br/>    policy_type               = optional(string)<br/>    predictive_scaling_configuration = optional(object({<br/>      max_capacity_breach_behavior = optional(string)<br/>      max_capacity_buffer          = optional(number)<br/>      metric_specification = object({<br/>        customized_capacity_metric_specification = optional(object({<br/>          metric_data_queries = optional(list(object({<br/>            expression = optional(string)<br/>            id         = string<br/>            label      = optional(string)<br/>            metric_stat = optional(object({<br/>              metric = object({<br/>                dimensions = optional(list(object({<br/>                  name  = string<br/>                  value = string<br/>                })))<br/>                metric_name = string<br/>                namespace   = string<br/>              })<br/>              stat = string<br/>              unit = optional(string)<br/>            }))<br/>            return_data = optional(bool)<br/>          })))<br/>        }))<br/>        customized_load_metric_specification = optional(object({<br/>          metric_data_queries = optional(list(object({<br/>            expression = optional(string)<br/>            id         = string<br/>            label      = optional(string)<br/>            metric_stat = optional(object({<br/>              metric = object({<br/>                dimensions = optional(list(object({<br/>                  name  = string<br/>                  value = string<br/>                })))<br/>                metric_name = string<br/>                namespace   = string<br/>              })<br/>              stat = string<br/>              unit = optional(string)<br/>            }))<br/>            return_data = optional(bool)<br/>          })))<br/>        }))<br/>        customized_scaling_metric_specification = optional(object({<br/>          metric_data_queries = optional(list(object({<br/>            expression = optional(string)<br/>            id         = string<br/>            label      = optional(string)<br/>            metric_stat = optional(object({<br/>              metric = object({<br/>                dimensions = optional(list(object({<br/>                  name  = string<br/>                  value = string<br/>                })))<br/>                metric_name = string<br/>                namespace   = string<br/>              })<br/>              stat = string<br/>              unit = optional(string)<br/>            }))<br/>            return_data = optional(bool)<br/>          })))<br/>        }))<br/>        predefined_load_metric_specification = optional(object({<br/>          predefined_metric_type = string<br/>          resource_label         = optional(string)<br/>        }))<br/>        predefined_metric_pair_specification = optional(object({<br/>          predefined_metric_type = string<br/>          resource_label         = optional(string)<br/>        }))<br/>        predefined_scaling_metric_specification = optional(object({<br/>          predefined_metric_type = string<br/>          resource_label         = optional(string)<br/>        }))<br/>        target_value = optional(number)<br/>      })<br/>      mode                   = optional(string)<br/>      scheduling_buffer_time = optional(number)<br/>    }))<br/>    scaling_adjustment = optional(number)<br/>    step_adjustment = optional(list(object({<br/>      metric_interval_lower_bound = optional(number)<br/>      metric_interval_upper_bound = optional(number)<br/>      scaling_adjustment          = number<br/>    })))<br/>    target_tracking_configuration = optional(object({<br/>      customized_metric_specification = optional(object({<br/>        metric_dimension = optional(list(object({<br/>          name  = string<br/>          value = string<br/>        })))<br/>        metric_name = optional(string)<br/>        metrics = optional(list(object({<br/>          expression = optional(string)<br/>          id         = string<br/>          label      = optional(string)<br/>          metric_stat = optional(object({<br/>            metric = object({<br/>              dimensions = optional(list(object({<br/>                name  = string<br/>                value = string<br/>              })))<br/>              metric_name = string<br/>              namespace   = string<br/>            })<br/>            period = optional(number)<br/>            stat   = string<br/>            unit   = optional(string)<br/>          }))<br/>          return_data = optional(bool)<br/>        })))<br/>        namespace = optional(string)<br/>        period    = optional(number)<br/>        statistic = optional(string)<br/>        unit      = optional(string)<br/>      }))<br/>      disable_scale_in = optional(bool)<br/>      predefined_metric_specification = optional(object({<br/>        predefined_metric_type = string<br/>        resource_label         = optional(string)<br/>      }))<br/>      target_value = number<br/>    }))<br/>  }))</pre> | `null` | no |
| <a name="input_schedules"></a> [schedules](#input\_schedules) | Map of autoscaling group schedule to create | <pre>map(object({<br/>    desired_capacity = optional(number)<br/>    end_time         = optional(string)<br/>    max_size         = optional(number)<br/>    min_size         = optional(number)<br/>    recurrence       = optional(string)<br/>    start_time       = optional(string)<br/>    time_zone        = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_secondary_interfaces"></a> [secondary\_interfaces](#input\_secondary\_interfaces) | Secondary interfaces to associate with instances launched from the template | <pre>list(object({<br/>    delete_on_termination    = optional(bool)<br/>    device_index             = optional(number)<br/>    interface_type           = optional(string)<br/>    network_card_index       = optional(number)<br/>    private_ip_address_count = optional(number)<br/>    private_ip_addresses     = optional(list(string))<br/>    secondary_subnet_id      = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | A list of security group IDs to associate | `list(string)` | `[]` | no |
| <a name="input_service_linked_role_arn"></a> [service\_linked\_role\_arn](#input\_service\_linked\_role\_arn) | The ARN of the service-linked role that the ASG will use to call other AWS services | `string` | `null` | no |
| <a name="input_suspended_processes"></a> [suspended\_processes](#input\_suspended\_processes) | A list of processes to suspend for the Auto Scaling Group. The allowed values are `Launch`, `Terminate`, `HealthCheck`, `ReplaceUnhealthy`, `AZRebalance`, `AlarmNotification`, `ScheduledActions`, `AddToLoadBalancer`, `InstanceRefresh`. Note that if you suspend either the `Launch` or `Terminate` process types, it can prevent your Auto Scaling Group from functioning properly | `list(string)` | `[]` | no |
| <a name="input_tag_specifications"></a> [tag\_specifications](#input\_tag\_specifications) | The tags to apply to the resources during launch | <pre>list(object({<br/>    resource_type = optional(string)<br/>    tags          = optional(map(string), {})<br/>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to resources | `map(string)` | `{}` | no |
| <a name="input_termination_policies"></a> [termination\_policies](#input\_termination\_policies) | A list of policies to decide how the instances in the Auto Scaling Group should be terminated. The allowed values are `OldestInstance`, `NewestInstance`, `OldestLaunchConfiguration`, `ClosestToNextInstanceHour`, `OldestLaunchTemplate`, `AllocationStrategy`, `Default` | `list(string)` | `[]` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeout configurations for the autoscaling group | <pre>object({<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_traffic_source_attachments"></a> [traffic\_source\_attachments](#input\_traffic\_source\_attachments) | Map of traffic source attachment definitions to create | <pre>map(object({<br/>    traffic_source_identifier = string<br/>    traffic_source_type       = optional(string, "elbv2")<br/>  }))</pre> | `null` | no |
| <a name="input_update_default_version"></a> [update\_default\_version](#input\_update\_default\_version) | Whether to update Default Version each update. Conflicts with `default_version` | `bool` | `null` | no |
| <a name="input_use_mixed_instances_policy"></a> [use\_mixed\_instances\_policy](#input\_use\_mixed\_instances\_policy) | Determines whether to use a mixed instances policy in the autoscaling group or not | `bool` | `false` | no |
| <a name="input_use_name_prefix"></a> [use\_name\_prefix](#input\_use\_name\_prefix) | Determines whether to use `name` as is or create a unique name beginning with the `name` as the prefix | `bool` | `true` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | The Base64-encoded user data to provide when launching the instance | `string` | `null` | no |
| <a name="input_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#input\_vpc\_zone\_identifier) | A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones` | `list(string)` | `null` | no |
| <a name="input_wait_for_capacity_timeout"></a> [wait\_for\_capacity\_timeout](#input\_wait\_for\_capacity\_timeout) | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior. | `string` | `null` | no |
| <a name="input_wait_for_elb_capacity"></a> [wait\_for\_elb\_capacity](#input\_wait\_for\_elb\_capacity) | Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over `min_elb_capacity` behavior. | `number` | `null` | no |
| <a name="input_warm_pool"></a> [warm\_pool](#input\_warm\_pool) | If this block is configured, add a Warm Pool to the specified Auto Scaling group | <pre>object({<br/>    instance_reuse_policy = optional(object({<br/>      reuse_on_scale_in = optional(bool)<br/>    }))<br/>    max_group_prepared_capacity = optional(number)<br/>    min_size                    = optional(number)<br/>    pool_state                  = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_autoscaling_group_availability_zones"></a> [autoscaling\_group\_availability\_zones](#output\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_autoscaling_group_default_cooldown"></a> [autoscaling\_group\_default\_cooldown](#output\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_autoscaling_group_desired_capacity"></a> [autoscaling\_group\_desired\_capacity](#output\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_autoscaling_group_enabled_metrics"></a> [autoscaling\_group\_enabled\_metrics](#output\_autoscaling\_group\_enabled\_metrics) | List of metrics enabled for collection |
| <a name="output_autoscaling_group_health_check_grace_period"></a> [autoscaling\_group\_health\_check\_grace\_period](#output\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_autoscaling_group_health_check_type"></a> [autoscaling\_group\_health\_check\_type](#output\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_autoscaling_group_id"></a> [autoscaling\_group\_id](#output\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_autoscaling_group_load_balancers"></a> [autoscaling\_group\_load\_balancers](#output\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_autoscaling_group_max_size"></a> [autoscaling\_group\_max\_size](#output\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_autoscaling_group_min_size"></a> [autoscaling\_group\_min\_size](#output\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_autoscaling_group_target_group_arns"></a> [autoscaling\_group\_target\_group\_arns](#output\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_autoscaling_group_vpc_zone_identifier"></a> [autoscaling\_group\_vpc\_zone\_identifier](#output\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_autoscaling_policy_arns"></a> [autoscaling\_policy\_arns](#output\_autoscaling\_policy\_arns) | ARNs of autoscaling policies |
| <a name="output_autoscaling_schedule_arns"></a> [autoscaling\_schedule\_arns](#output\_autoscaling\_schedule\_arns) | ARNs of autoscaling group schedules |
| <a name="output_iam_instance_profile_arn"></a> [iam\_instance\_profile\_arn](#output\_iam\_instance\_profile\_arn) | ARN assigned by AWS to the instance profile |
| <a name="output_iam_instance_profile_id"></a> [iam\_instance\_profile\_id](#output\_iam\_instance\_profile\_id) | Instance profile's ID |
| <a name="output_iam_instance_profile_unique"></a> [iam\_instance\_profile\_unique](#output\_iam\_instance\_profile\_unique) | Stable and unique string identifying the IAM instance profile |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The name of the IAM role |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_launch_template_arn"></a> [launch\_template\_arn](#output\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_launch_template_default_version"></a> [launch\_template\_default\_version](#output\_launch\_template\_default\_version) | The default version of the launch template |
| <a name="output_launch_template_id"></a> [launch\_template\_id](#output\_launch\_template\_id) | The ID of the launch template |
| <a name="output_launch_template_latest_version"></a> [launch\_template\_latest\_version](#output\_launch\_template\_latest\_version) | The latest version of the launch template |
| <a name="output_launch_template_name"></a> [launch\_template\_name](#output\_launch\_template\_name) | The name of the launch template |
<!-- END_TF_DOCS -->

## Notes
- A refresh will not start if `launch_template_version` is set to `$Latest` when using an external launch template. To trigger the refresh when the external launch template is changed, set this to `latest_version` of that `aws_launch_template resource`.

## Authors

Module is maintained by [Anton Babenko](https://github.com/antonbabenko) with help from [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/LICENSE) for full details.

## Additional information for users from Russia and Belarus

* Russia has [illegally annexed Crimea in 2014](https://en.wikipedia.org/wiki/Annexation_of_Crimea_by_the_Russian_Federation) and [brought the war in Donbas](https://en.wikipedia.org/wiki/War_in_Donbas) followed by [full-scale invasion of Ukraine in 2022](https://en.wikipedia.org/wiki/2022_Russian_invasion_of_Ukraine).
* Russia has brought sorrow and devastations to millions of Ukrainians, killed hundreds of innocent people, damaged thousands of buildings, and forced several million people to flee.
* [Putin khuylo!](https://en.wikipedia.org/wiki/Putin_khuylo!)
