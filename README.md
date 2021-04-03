# AWS Auto Scaling Group (ASG) Terraform module

Terraform module which creates Auto Scaling resources on AWS.

These types of resources are supported:

- [Auto Scaling Group](https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html)
- [Launch Configuration](https://www.terraform.io/docs/providers/aws/r/launch_configuration.html)
- [Launch Template](https://www.terraform.io/docs/providers/aws/r/launch_template.html)

Available features

- Autoscaling of read-replicas (based on CPU utilization)
- Enhanced Monitoring

## Usage

```hcl
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 4.0"

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
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch template
  lt_name                = "example-asg"
  description            = "Launch template example"
  update_default_version = true

  use_lt    = true
  create_lt = true

  image_id          = "ami-ebd02392"
  instance_type     = "t3.micro"
  ebs_optimized     = true
  enable_monitoring = true

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

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 32
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
```

## Conditional creation

The following combinations are supported to conditionally create resources and/or use externally created resources within the module:

- Disable resource creation (no resources created):

```hcl
  create_asg = false
```

- Create both the autoscaling group and launch configuration:

```hcl
  use_lc    = true
  create_lc = true
```

- Create both the autoscaling group and launch template:

```hcl
  use_lt    = true
  create_lt = true
```

- Create the autoscaling group using an externally created launch configuration:

```hcl
  use_lc               = true
  launch_configuration = aws_launch_configuration.my_launch_config.name
```

- Create the autoscaling group using an externally created launch template:

```hcl
  use_lt          = true
  launch_template = aws_launch_template.my_launch_template.name
```

## Tags

There are two ways to specify tags for auto-scaling group in this module - `tags` and `tags_as_map`.

```hcl
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
```

## Examples

- [Auto Scaling Group without ELB](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/asg_ec2)
- [Auto Scaling Group with ELB](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/asg_elb)
- [Auto Scaling Group with external Launch Configuration](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/asg_ec2_external_launch_configuration)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

| Name                                                                     | Version    |
| ------------------------------------------------------------------------ | ---------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.12.26 |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 3.30    |
| <a name="requirement_null"></a> [null](#requirement_null)                | >= 2.0     |

## Providers

| Name                                                | Version |
| --------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws)    | >= 3.30 |
| <a name="provider_null"></a> [null](#provider_null) | >= 2.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                              | Type     |
| --------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group)       | resource |
| [aws_launch_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template)           | resource |
| [null_resource.tags_as_list_of_maps](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)       | resource |

## Inputs

| Name                                                                                                                                          | Description                                                                                                                                                                                                                                                                                                                                                                                         | Type                | Default | Required |
| --------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- | ------- | :------: |
| <a name="input_associate_public_ip_address"></a> [associate_public_ip_address](#input_associate_public_ip_address)                            | (LC) Associate a public ip address with an instance in a VPC                                                                                                                                                                                                                                                                                                                                        | `bool`              | `null`  |    no    |
| <a name="input_availability_zone"></a> [availability_zone](#input_availability_zone)                                                          | A list of one or more availability zones for the group. Used for EC2-Classic and default subnets when not specified with `vpc_zone_identifier` argument. Conflicts with `vpc_zone_identifier`                                                                                                                                                                                                       | `list(string)`      | `null`  |    no    |
| <a name="input_block_device_mappings"></a> [block_device_mappings](#input_block_device_mappings)                                              | (LT) Specify volumes to attach to the instance besides the volumes specified by the AMI                                                                                                                                                                                                                                                                                                             | `list(any)`         | `[]`    |    no    |
| <a name="input_capacity_rebalance"></a> [capacity_rebalance](#input_capacity_rebalance)                                                       | Indicates whether capacity rebalance is enabled                                                                                                                                                                                                                                                                                                                                                     | `bool`              | `null`  |    no    |
| <a name="input_capacity_reservation_specification"></a> [capacity_reservation_specification](#input_capacity_reservation_specification)       | (LT) Targeting for EC2 capacity reservations                                                                                                                                                                                                                                                                                                                                                        | `any`               | `null`  |    no    |
| <a name="input_cpu_options"></a> [cpu_options](#input_cpu_options)                                                                            | (LT) The CPU options for the instance                                                                                                                                                                                                                                                                                                                                                               | `map(string)`       | `null`  |    no    |
| <a name="input_create_asg"></a> [create_asg](#input_create_asg)                                                                               | Determines whether to create autoscaling group or not                                                                                                                                                                                                                                                                                                                                               | `bool`              | `true`  |    no    |
| <a name="input_create_lc"></a> [create_lc](#input_create_lc)                                                                                  | Determines whether to create launch configuration or not                                                                                                                                                                                                                                                                                                                                            | `bool`              | `false` |    no    |
| <a name="input_create_lt"></a> [create_lt](#input_create_lt)                                                                                  | Determines whether to create launch template or not                                                                                                                                                                                                                                                                                                                                                 | `bool`              | `false` |    no    |
| <a name="input_credit_specification"></a> [credit_specification](#input_credit_specification)                                                 | (LT) Customize the credit specification of the instance                                                                                                                                                                                                                                                                                                                                             | `map(string)`       | `null`  |    no    |
| <a name="input_default_cooldown"></a> [default_cooldown](#input_default_cooldown)                                                             | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start                                                                                                                                                                                                                                                                                        | `number`            | `null`  |    no    |
| <a name="input_default_version"></a> [default_version](#input_default_version)                                                                | (LT) Default Version of the launch template                                                                                                                                                                                                                                                                                                                                                         | `string`            | `null`  |    no    |
| <a name="input_delete_timeout"></a> [delete_timeout](#input_delete_timeout)                                                                   | Delete timeout to wait for destroying autoscaling group                                                                                                                                                                                                                                                                                                                                             | `string`            | `null`  |    no    |
| <a name="input_description"></a> [description](#input_description)                                                                            | (LT) Description of the launch template                                                                                                                                                                                                                                                                                                                                                             | `string`            | `null`  |    no    |
| <a name="input_desired_capacity"></a> [desired_capacity](#input_desired_capacity)                                                             | The number of Amazon EC2 instances that should be running in the autoscaling group                                                                                                                                                                                                                                                                                                                  | `number`            | `null`  |    no    |
| <a name="input_disable_api_termination"></a> [disable_api_termination](#input_disable_api_termination)                                        | (LT) If true, enables EC2 instance termination protection                                                                                                                                                                                                                                                                                                                                           | `bool`              | `null`  |    no    |
| <a name="input_ebs_block_device"></a> [ebs_block_device](#input_ebs_block_device)                                                             | (LC) Additional EBS block devices to attach to the instance                                                                                                                                                                                                                                                                                                                                         | `list(map(string))` | `[]`    |    no    |
| <a name="input_ebs_optimized"></a> [ebs_optimized](#input_ebs_optimized)                                                                      | If true, the launched EC2 instance will be EBS-optimized                                                                                                                                                                                                                                                                                                                                            | `bool`              | `null`  |    no    |
| <a name="input_elastic_gpu_specifications"></a> [elastic_gpu_specifications](#input_elastic_gpu_specifications)                               | (LT) The elastic GPU to attach to the instance                                                                                                                                                                                                                                                                                                                                                      | `map(string)`       | `null`  |    no    |
| <a name="input_elastic_inference_accelerator"></a> [elastic_inference_accelerator](#input_elastic_inference_accelerator)                      | (LT) Configuration block containing an Elastic Inference Accelerator to attach to the instance                                                                                                                                                                                                                                                                                                      | `map(string)`       | `null`  |    no    |
| <a name="input_enable_monitoring"></a> [enable_monitoring](#input_enable_monitoring)                                                          | Enables/disables detailed monitoring                                                                                                                                                                                                                                                                                                                                                                | `bool`              | `null`  |    no    |
| <a name="input_enabled_metrics"></a> [enabled_metrics](#input_enabled_metrics)                                                                | A list of metrics to collect. The allowed values are `GroupDesiredCapacity`, `GroupInServiceCapacity`, `GroupPendingCapacity`, `GroupMinSize`, `GroupMaxSize`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupStandbyCapacity`, `GroupTerminatingCapacity`, `GroupTerminatingInstances`, `GroupTotalCapacity`, `GroupTotalInstances`                            | `list(string)`      | `null`  |    no    |
| <a name="input_enclave_options"></a> [enclave_options](#input_enclave_options)                                                                | (LT) Enable Nitro Enclaves on launched instances                                                                                                                                                                                                                                                                                                                                                    | `map(string)`       | `null`  |    no    |
| <a name="input_ephemeral_block_device"></a> [ephemeral_block_device](#input_ephemeral_block_device)                                           | (LC) Customize Ephemeral (also known as 'Instance Store') volumes on the instance                                                                                                                                                                                                                                                                                                                   | `list(map(string))` | `[]`    |    no    |
| <a name="input_force_delete"></a> [force_delete](#input_force_delete)                                                                         | Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate. You can force an Auto Scaling Group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling                                                   | `bool`              | `null`  |    no    |
| <a name="input_health_check_grace_period"></a> [health_check_grace_period](#input_health_check_grace_period)                                  | Time (in seconds) after instance comes into service before checking health                                                                                                                                                                                                                                                                                                                          | `number`            | `null`  |    no    |
| <a name="input_health_check_type"></a> [health_check_type](#input_health_check_type)                                                          | `EC2` or `ELB`. Controls how health checking is done                                                                                                                                                                                                                                                                                                                                                | `string`            | `null`  |    no    |
| <a name="input_hibernation_options"></a> [hibernation_options](#input_hibernation_options)                                                    | (LT) The hibernation options for the instance                                                                                                                                                                                                                                                                                                                                                       | `map(string)`       | `null`  |    no    |
| <a name="input_iam_instance_profile_arn"></a> [iam_instance_profile_arn](#input_iam_instance_profile_arn)                                     | (LT) The IAM Instance Profile ARN to launch the instance with                                                                                                                                                                                                                                                                                                                                       | `string`            | `null`  |    no    |
| <a name="input_iam_instance_profile_name"></a> [iam_instance_profile_name](#input_iam_instance_profile_name)                                  | The name attribute of the IAM instance profile to associate with launched instances                                                                                                                                                                                                                                                                                                                 | `string`            | `null`  |    no    |
| <a name="input_image_id"></a> [image_id](#input_image_id)                                                                                     | The AMI from which to launch the instance                                                                                                                                                                                                                                                                                                                                                           | `string`            | `""`    |    no    |
| <a name="input_initial_lifecycle_hooks"></a> [initial_lifecycle_hooks](#input_initial_lifecycle_hooks)                                        | One or more Lifecycle Hooks to attach to the Auto Scaling Group before instances are launched. The syntax is exactly the same as the separate `aws_autoscaling_lifecycle_hook` resource, without the `autoscaling_group_name` attribute. Please note that this will only work when creating a new Auto Scaling Group. For all other use-cases, please use `aws_autoscaling_lifecycle_hook` resource | `list(map(string))` | `[]`    |    no    |
| <a name="input_instance_initiated_shutdown_behavior"></a> [instance_initiated_shutdown_behavior](#input_instance_initiated_shutdown_behavior) | (LT) Shutdown behavior for the instance. Can be `stop` or `terminate`. (Default: `stop`)                                                                                                                                                                                                                                                                                                            | `string`            | `null`  |    no    |
| <a name="input_instance_market_options"></a> [instance_market_options](#input_instance_market_options)                                        | (LT) The market (purchasing) option for the instance                                                                                                                                                                                                                                                                                                                                                | `any`               | `null`  |    no    |
| <a name="input_instance_refresh"></a> [instance_refresh](#input_instance_refresh)                                                             | If this block is configured, start an Instance Refresh when this Auto Scaling Group is updated                                                                                                                                                                                                                                                                                                      | `any`               | `null`  |    no    |
| <a name="input_instance_type"></a> [instance_type](#input_instance_type)                                                                      | The type of the instance to launch                                                                                                                                                                                                                                                                                                                                                                  | `string`            | `""`    |    no    |
| <a name="input_kernel_id"></a> [kernel_id](#input_kernel_id)                                                                                  | (LT) The kernel ID                                                                                                                                                                                                                                                                                                                                                                                  | `string`            | `null`  |    no    |
| <a name="input_key_name"></a> [key_name](#input_key_name)                                                                                     | The key name that should be used for the instance                                                                                                                                                                                                                                                                                                                                                   | `string`            | `null`  |    no    |
| <a name="input_launch_configuration"></a> [launch_configuration](#input_launch_configuration)                                                 | Name of an existing launch configuration to be used (created outside of this module)                                                                                                                                                                                                                                                                                                                | `string`            | `null`  |    no    |
| <a name="input_launch_template"></a> [launch_template](#input_launch_template)                                                                | Name of an existing launch template to be used (created outside of this module)                                                                                                                                                                                                                                                                                                                     | `string`            | `null`  |    no    |
| <a name="input_lc_name"></a> [lc_name](#input_lc_name)                                                                                        | Name of launch configuration to be created                                                                                                                                                                                                                                                                                                                                                          | `string`            | `""`    |    no    |
| <a name="input_lc_use_name_prefix"></a> [lc_use_name_prefix](#input_lc_use_name_prefix)                                                       | Determines whether to use `lc_name` as is or create a unique name beginning with the `lc_name` as the prefix                                                                                                                                                                                                                                                                                        | `bool`              | `true`  |    no    |
| <a name="input_license_specifications"></a> [license_specifications](#input_license_specifications)                                           | (LT) A list of license specifications to associate with                                                                                                                                                                                                                                                                                                                                             | `map(string)`       | `null`  |    no    |
| <a name="input_load_balancers"></a> [load_balancers](#input_load_balancers)                                                                   | A list of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use `target_group_arns` instead                                                                                                                                                                                                                                       | `list(string)`      | `[]`    |    no    |
| <a name="input_lt_name"></a> [lt_name](#input_lt_name)                                                                                        | Name of launch template to be created                                                                                                                                                                                                                                                                                                                                                               | `string`            | `""`    |    no    |
| <a name="input_lt_use_name_prefix"></a> [lt_use_name_prefix](#input_lt_use_name_prefix)                                                       | Determines whether to use `lt_name` as is or create a unique name beginning with the `lt_name` as the prefix                                                                                                                                                                                                                                                                                        | `bool`              | `true`  |    no    |
| <a name="input_lt_version"></a> [lt_version](#input_lt_version)                                                                               | Launch template version. Can be version number, `$Latest`, or `$Default`                                                                                                                                                                                                                                                                                                                            | `string`            | `null`  |    no    |
| <a name="input_max_instance_lifetime"></a> [max_instance_lifetime](#input_max_instance_lifetime)                                              | The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds                                                                                                                                                                                                                                                 | `number`            | `null`  |    no    |
| <a name="input_max_size"></a> [max_size](#input_max_size)                                                                                     | The maximum size of the autoscaling group                                                                                                                                                                                                                                                                                                                                                           | `number`            | `null`  |    no    |
| <a name="input_metadata_options"></a> [metadata_options](#input_metadata_options)                                                             | Customize the metadata options for the instance                                                                                                                                                                                                                                                                                                                                                     | `map(string)`       | `null`  |    no    |
| <a name="input_metrics_granularity"></a> [metrics_granularity](#input_metrics_granularity)                                                    | The granularity to associate with the metrics to collect. The only valid value is `1Minute`                                                                                                                                                                                                                                                                                                         | `string`            | `null`  |    no    |
| <a name="input_min_elb_capacity"></a> [min_elb_capacity](#input_min_elb_capacity)                                                             | Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes                                                                                                                                                                                                                             | `number`            | `null`  |    no    |
| <a name="input_min_size"></a> [min_size](#input_min_size)                                                                                     | The minimum size of the autoscaling group                                                                                                                                                                                                                                                                                                                                                           | `number`            | `null`  |    no    |
| <a name="input_mixed_instances_policy"></a> [mixed_instances_policy](#input_mixed_instances_policy)                                           | Configuration block containing settings to define launch targets for Auto Scaling groups                                                                                                                                                                                                                                                                                                            | `any`               | `null`  |    no    |
| <a name="input_name"></a> [name](#input_name)                                                                                                 | Name used across the resources created                                                                                                                                                                                                                                                                                                                                                              | `string`            | n/a     |   yes    |
| <a name="input_network_interfaces"></a> [network_interfaces](#input_network_interfaces)                                                       | (LT) Customize network interfaces to be attached at instance boot time                                                                                                                                                                                                                                                                                                                              | `list(any)`         | `[]`    |    no    |
| <a name="input_placement"></a> [placement](#input_placement)                                                                                  | (LT) The placement of the instance                                                                                                                                                                                                                                                                                                                                                                  | `map(string)`       | `null`  |    no    |
| <a name="input_placement_group"></a> [placement_group](#input_placement_group)                                                                | The name of the placement group into which you'll launch your instances, if any                                                                                                                                                                                                                                                                                                                     | `string`            | `null`  |    no    |
| <a name="input_placement_tenancy"></a> [placement_tenancy](#input_placement_tenancy)                                                          | (LC) The tenancy of the instance. Valid values are `default` or `dedicated`                                                                                                                                                                                                                                                                                                                         | `string`            | `null`  |    no    |
| <a name="input_protect_from_scale_in"></a> [protect_from_scale_in](#input_protect_from_scale_in)                                              | Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events.                                                                                                                                                                                                                                                       | `bool`              | `false` |    no    |
| <a name="input_ram_disk_id"></a> [ram_disk_id](#input_ram_disk_id)                                                                            | (LT) The ID of the ram disk                                                                                                                                                                                                                                                                                                                                                                         | `string`            | `null`  |    no    |
| <a name="input_root_block_device"></a> [root_block_device](#input_root_block_device)                                                          | (LC) Customize details about the root block device of the instance                                                                                                                                                                                                                                                                                                                                  | `list(map(string))` | `[]`    |    no    |
| <a name="input_security_groups"></a> [security_groups](#input_security_groups)                                                                | A list of security group IDs to associate                                                                                                                                                                                                                                                                                                                                                           | `list(string)`      | `null`  |    no    |
| <a name="input_service_linked_role_arn"></a> [service_linked_role_arn](#input_service_linked_role_arn)                                        | The ARN of the service-linked role that the ASG will use to call other AWS services                                                                                                                                                                                                                                                                                                                 | `string`            | `null`  |    no    |
| <a name="input_spot_price"></a> [spot_price](#input_spot_price)                                                                               | (LC) The maximum price to use for reserving spot instances (defaults to on-demand price)                                                                                                                                                                                                                                                                                                            | `string`            | `null`  |    no    |
| <a name="input_suspended_processes"></a> [suspended_processes](#input_suspended_processes)                                                    | A list of processes to suspend for the Auto Scaling Group. The allowed values are `Launch`, `Terminate`, `HealthCheck`, `ReplaceUnhealthy`, `AZRebalance`, `AlarmNotification`, `ScheduledActions`, `AddToLoadBalancer`. Note that if you suspend either the `Launch` or `Terminate` process types, it can prevent your Auto Scaling Group from functioning properly                                | `list(string)`      | `null`  |    no    |
| <a name="input_tag_specifications"></a> [tag_specifications](#input_tag_specifications)                                                       | (LT) The tags to apply to the resources during launch                                                                                                                                                                                                                                                                                                                                               | `list(any)`         | `[]`    |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                                                 | A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch                                                                                                                                                                                                                                                                                                       | `list(map(string))` | `[]`    |    no    |
| <a name="input_tags_as_map"></a> [tags_as_map](#input_tags_as_map)                                                                            | A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws_autoscaling_group requires.                                                                                                                                                                                                                                 | `map(string)`       | `{}`    |    no    |
| <a name="input_target_group_arns"></a> [target_group_arns](#input_target_group_arns)                                                          | A set of `aws_alb_target_group` ARNs, for use with Application or Network Load Balancing                                                                                                                                                                                                                                                                                                            | `list(string)`      | `[]`    |    no    |
| <a name="input_termination_policies"></a> [termination_policies](#input_termination_policies)                                                 | A list of policies to decide how the instances in the Auto Scaling Group should be terminated. The allowed values are `OldestInstance`, `NewestInstance`, `OldestLaunchConfiguration`, `ClosestToNextInstanceHour`, `OldestLaunchTemplate`, `AllocationStrategy`, `Default`                                                                                                                         | `list(string)`      | `null`  |    no    |
| <a name="input_update_default_version"></a> [update_default_version](#input_update_default_version)                                           | (LT) Whether to update Default Version each update. Conflicts with `default_version`                                                                                                                                                                                                                                                                                                                | `string`            | `null`  |    no    |
| <a name="input_use_lc"></a> [use_lc](#input_use_lc)                                                                                           | Determines whether to use a launch configuration in the autoscaling group or not                                                                                                                                                                                                                                                                                                                    | `bool`              | `false` |    no    |
| <a name="input_use_lt"></a> [use_lt](#input_use_lt)                                                                                           | Determines whether to use a launch template in the autoscaling group or not                                                                                                                                                                                                                                                                                                                         | `bool`              | `false` |    no    |
| <a name="input_use_mixed_instances_policy"></a> [use_mixed_instances_policy](#input_use_mixed_instances_policy)                               | Determines whether to use a mixed instances policy in the autoscaling group or not                                                                                                                                                                                                                                                                                                                  | `bool`              | `false` |    no    |
| <a name="input_use_name_prefix"></a> [use_name_prefix](#input_use_name_prefix)                                                                | Determines whether to use `name` as is or create a unique name beginning with the `name` as the prefix                                                                                                                                                                                                                                                                                              | `bool`              | `true`  |    no    |
| <a name="input_user_data"></a> [user_data](#input_user_data)                                                                                  | (LC) The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see `user_data_base64` instead                                                                                                                                                                                                                                                       | `string`            | `null`  |    no    |
| <a name="input_user_data_base64"></a> [user_data_base64](#input_user_data_base64)                                                             | The Base64-encoded user data to provide when launching the instance                                                                                                                                                                                                                                                                                                                                 | `string`            | `null`  |    no    |
| <a name="input_vpc_zone_identifier"></a> [vpc_zone_identifier](#input_vpc_zone_identifier)                                                    | A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones`                                                                                                                                                                                                                                    | `list(string)`      | `null`  |    no    |
| <a name="input_wait_for_capacity_timeout"></a> [wait_for_capacity_timeout](#input_wait_for_capacity_timeout)                                  | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior.                                                                                                                                                                                 | `string`            | `null`  |    no    |
| <a name="input_wait_for_elb_capacity"></a> [wait_for_elb_capacity](#input_wait_for_elb_capacity)                                              | Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over `min_elb_capacity` behavior.                                                                                                                                                                                      | `number`            | `null`  |    no    |

## Outputs

| Name                                                                                                                                                                 | Description                                                            |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| <a name="output_autoscaling_group_arn"></a> [autoscaling_group_arn](#output_autoscaling_group_arn)                                                                   | The ARN for this AutoScaling Group                                     |
| <a name="output_autoscaling_group_availability_zones"></a> [autoscaling_group_availability_zones](#output_autoscaling_group_availability_zones)                      | The availability zones of the autoscale group                          |
| <a name="output_autoscaling_group_default_cooldown"></a> [autoscaling_group_default_cooldown](#output_autoscaling_group_default_cooldown)                            | Time between a scaling activity and the succeeding scaling activity    |
| <a name="output_autoscaling_group_desired_capacity"></a> [autoscaling_group_desired_capacity](#output_autoscaling_group_desired_capacity)                            | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_autoscaling_group_health_check_grace_period"></a> [autoscaling_group_health_check_grace_period](#output_autoscaling_group_health_check_grace_period) | Time after instance comes into service before checking health          |
| <a name="output_autoscaling_group_health_check_type"></a> [autoscaling_group_health_check_type](#output_autoscaling_group_health_check_type)                         | EC2 or ELB. Controls how health checking is done                       |
| <a name="output_autoscaling_group_id"></a> [autoscaling_group_id](#output_autoscaling_group_id)                                                                      | The autoscaling group id                                               |
| <a name="output_autoscaling_group_load_balancers"></a> [autoscaling_group_load_balancers](#output_autoscaling_group_load_balancers)                                  | The load balancer names associated with the autoscaling group          |
| <a name="output_autoscaling_group_max_size"></a> [autoscaling_group_max_size](#output_autoscaling_group_max_size)                                                    | The maximum size of the autoscale group                                |
| <a name="output_autoscaling_group_min_size"></a> [autoscaling_group_min_size](#output_autoscaling_group_min_size)                                                    | The minimum size of the autoscale group                                |
| <a name="output_autoscaling_group_name"></a> [autoscaling_group_name](#output_autoscaling_group_name)                                                                | The autoscaling group name                                             |
| <a name="output_autoscaling_group_target_group_arns"></a> [autoscaling_group_target_group_arns](#output_autoscaling_group_target_group_arns)                         | List of Target Group ARNs that apply to this AutoScaling Group         |
| <a name="output_autoscaling_group_vpc_zone_identifier"></a> [autoscaling_group_vpc_zone_identifier](#output_autoscaling_group_vpc_zone_identifier)                   | The VPC zone identifier                                                |
| <a name="output_launch_configuration_arn"></a> [launch_configuration_arn](#output_launch_configuration_arn)                                                          | The ARN of the launch configuration                                    |
| <a name="output_launch_configuration_id"></a> [launch_configuration_id](#output_launch_configuration_id)                                                             | The ID of the launch configuration                                     |
| <a name="output_launch_configuration_name"></a> [launch_configuration_name](#output_launch_configuration_name)                                                       | The name of the launch configuration                                   |
| <a name="output_launch_template_arn"></a> [launch_template_arn](#output_launch_template_arn)                                                                         | The ARN of the launch template                                         |
| <a name="output_launch_template_id"></a> [launch_template_id](#output_launch_template_id)                                                                            | The ID of the launch template                                          |
| <a name="output_launch_template_latest_version"></a> [launch_template_latest_version](#output_launch_template_latest_version)                                        | The latest version of the launch template                              |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Currently maintained by [Anton Babenko](https://github.com/antonbabenko) and [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/LICENSE) for full details.
