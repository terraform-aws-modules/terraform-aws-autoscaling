# AWS Auto Scaling Group (ASG) Terraform module

Terraform module which creates Auto Scaling resources on AWS.

These types of resources are supported:

* [Launch Configuration](https://www.terraform.io/docs/providers/aws/r/launch_configuration.html)
* [Auto Scaling Group](https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html)

## Terraform versions

Terraform 0.12. Pin module version to `~> v3.0`. Submit pull-requests to `master` branch.

## Usage

```hcl
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"
  
  name = "service"

  # Launch configuration
  lc_name = "example-lc"

  image_id        = "ami-ebd02392"
  instance_type   = "t2.micro"
  security_groups = ["sg-12345678"]

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "50"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "example-asg"
  vpc_zone_identifier       = ["subnet-1235678", "subnet-87654321"]
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
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
```

## Conditional creation

Normally this module creates both Auto Scaling Group (ASG) and Launch Configuration (LC), and connect them together.
It is possible to customize this behaviour passing different parameters to this module:
1. To create ASG, but not LC. Associate ASG with an existing LC:
```hcl
create_lc = false
launch_configuration = "existing-launch-configuration"
```

1. To create LC, but not ASG. Outputs may produce errors.
```hcl
create_asg = false
```

1. To create ASG with initial lifecycle hook
```hcl
create_asg_with_initial_lifecycle_hook = true

initial_lifecycle_hook_name                  = "NameOfLifeCycleHook"
initial_lifecycle_hook_lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
initial_lifecycle_hook_notification_metadata =<<EOF
{
  "foo": "bar"
}
EOF
```
1. To disable creation of both resources (LC and ASG) you can specify both arguments `create_lc = false` and `create_asg = false`. Sometimes you need to use this way to create resources in modules conditionally but Terraform does not allow to use `count` inside `module` block.

## Tags

There are two ways to specify tags for auto-scaling group in this module - `tags` and `tags_as_map`. See [examples/asg_ec2/main.tf](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/blob/master/examples/asg_ec2/main.tf) for example.

## Examples

* [Auto Scaling Group without ELB](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/asg_ec2)
* [Auto Scaling Group with ELB](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/asg_elb)
* [Auto Scaling Group with external Launch Configuration](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/asg_ec2_external_launch_configuration)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.26 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.41 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.41 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [null_resource.tags_as_list_of_maps](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | (LC) Associate a public ip address with an instance in a VPC | `bool` | `null` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | A list of one or more availability zones for the group. Used for EC2-Classic and default subnets when not specified with `vpc_zone_identifier` argument. Conflicts with `vpc_zone_identifier` | `list(string)` | `null` | no |
| <a name="input_block_device_mappings"></a> [block\_device\_mappings](#input\_block\_device\_mappings) | (LT) Specify volumes to attach to the instance besides the volumes specified by the AMI | `list(any)` | `[]` | no |
| <a name="input_capacity_rebalance"></a> [capacity\_rebalance](#input\_capacity\_rebalance) | Indicates whether capacity rebalance is enabled | `bool` | `null` | no |
| <a name="input_capacity_reservation_specification"></a> [capacity\_reservation\_specification](#input\_capacity\_reservation\_specification) | (LT) Targeting for EC2 capacity reservations | `any` | `null` | no |
| <a name="input_cpu_options"></a> [cpu\_options](#input\_cpu\_options) | (LT) The CPU options for the instance | `map(string)` | `null` | no |
| <a name="input_create_asg"></a> [create\_asg](#input\_create\_asg) | Determines whether to create autoscaling group or not | `bool` | `true` | no |
| <a name="input_create_lc"></a> [create\_lc](#input\_create\_lc) | Determines whether to create launch configuration or not | `bool` | `false` | no |
| <a name="input_create_lt"></a> [create\_lt](#input\_create\_lt) | Determines whether to create launch template or not | `bool` | `false` | no |
| <a name="input_credit_specification"></a> [credit\_specification](#input\_credit\_specification) | (LT) Customize the credit specification of the instance | `map(string)` | `null` | no |
| <a name="input_default_cooldown"></a> [default\_cooldown](#input\_default\_cooldown) | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start | `number` | `null` | no |
| <a name="input_default_version"></a> [default\_version](#input\_default\_version) | (LT) Default Version of the launch template | `string` | `null` | no |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | Delete timeout to wait for destroying autoscaling group | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | (LT) Description of the launch template | `string` | `null` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the autoscaling group | `number` | `null` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | (LT) If true, enables EC2 instance termination protection | `bool` | `null` | no |
| <a name="input_ebs_block_device"></a> [ebs\_block\_device](#input\_ebs\_block\_device) | (LC) Additional EBS block devices to attach to the instance | `list(map(string))` | `[]` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `null` | no |
| <a name="input_elastic_gpu_specifications"></a> [elastic\_gpu\_specifications](#input\_elastic\_gpu\_specifications) | (LT) The elastic GPU to attach to the instance | `map(string)` | `null` | no |
| <a name="input_elastic_inference_accelerator"></a> [elastic\_inference\_accelerator](#input\_elastic\_inference\_accelerator) | (LT) Configuration block containing an Elastic Inference Accelerator to attach to the instance | `map(string)` | `null` | no |
| <a name="input_enable_monitoring"></a> [enable\_monitoring](#input\_enable\_monitoring) | Enables/disables detailed monitoring | `bool` | `null` | no |
| <a name="input_enabled_metrics"></a> [enabled\_metrics](#input\_enabled\_metrics) | A list of metrics to collect. The allowed values are `GroupDesiredCapacity`, `GroupInServiceCapacity`, `GroupPendingCapacity`, `GroupMinSize`, `GroupMaxSize`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupStandbyCapacity`, `GroupTerminatingCapacity`, `GroupTerminatingInstances`, `GroupTotalCapacity`, `GroupTotalInstances` | `list(string)` | `null` | no |
| <a name="input_enclave_options"></a> [enclave\_options](#input\_enclave\_options) | (LT) Enable Nitro Enclaves on launched instances | `map(string)` | `null` | no |
| <a name="input_ephemeral_block_device"></a> [ephemeral\_block\_device](#input\_ephemeral\_block\_device) | (LC) Customize Ephemeral (also known as 'Instance Store') volumes on the instance | `list(map(string))` | `[]` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate. You can force an Auto Scaling Group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling | `bool` | `null` | no |
| <a name="input_health_check_grace_period"></a> [health\_check\_grace\_period](#input\_health\_check\_grace\_period) | Time (in seconds) after instance comes into service before checking health | `number` | `null` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | `EC2` or `ELB`. Controls how health checking is done | `string` | `null` | no |
| <a name="input_hibernation_options"></a> [hibernation\_options](#input\_hibernation\_options) | (LT) The hibernation options for the instance | `map(string)` | `null` | no |
| <a name="input_iam_instance_profile_arn"></a> [iam\_instance\_profile\_arn](#input\_iam\_instance\_profile\_arn) | (LT) The IAM Instance Profile ARN to launch the instance with | `string` | `null` | no |
| <a name="input_iam_instance_profile_name"></a> [iam\_instance\_profile\_name](#input\_iam\_instance\_profile\_name) | The name attribute of the IAM instance profile to associate with launched instances | `string` | `null` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The AMI from which to launch the instance | `string` | `""` | no |
| <a name="input_initial_lifecycle_hooks"></a> [initial\_lifecycle\_hooks](#input\_initial\_lifecycle\_hooks) | One or more Lifecycle Hooks to attach to the Auto Scaling Group before instances are launched. The syntax is exactly the same as the separate `aws_autoscaling_lifecycle_hook` resource, without the `autoscaling_group_name` attribute. Please note that this will only work when creating a new Auto Scaling Group. For all other use-cases, please use `aws_autoscaling_lifecycle_hook` resource | `list(map(string))` | `[]` | no |
| <a name="input_instance_initiated_shutdown_behavior"></a> [instance\_initiated\_shutdown\_behavior](#input\_instance\_initiated\_shutdown\_behavior) | (LT) Shutdown behavior for the instance. Can be `stop` or `terminate`. (Default: `stop`) | `string` | `null` | no |
| <a name="input_instance_market_options"></a> [instance\_market\_options](#input\_instance\_market\_options) | (LT) The market (purchasing) option for the instance | `any` | `null` | no |
| <a name="input_instance_refresh"></a> [instance\_refresh](#input\_instance\_refresh) | If this block is configured, start an Instance Refresh when this Auto Scaling Group is updated | `any` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance to launch | `string` | `""` | no |
| <a name="input_kernel_id"></a> [kernel\_id](#input\_kernel\_id) | (LT) The kernel ID | `string` | `null` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The key name that should be used for the instance | `string` | `null` | no |
| <a name="input_launch_configuration"></a> [launch\_configuration](#input\_launch\_configuration) | Name of an existing launch configuration to be used (created outside of this module) | `string` | `null` | no |
| <a name="input_launch_template"></a> [launch\_template](#input\_launch\_template) | Name of an existing launch template to be used (created outside of this module) | `string` | `null` | no |
| <a name="input_lc_name"></a> [lc\_name](#input\_lc\_name) | Name of launch configuration to be created | `string` | `""` | no |
| <a name="input_lc_use_name_prefix"></a> [lc\_use\_name\_prefix](#input\_lc\_use\_name\_prefix) | Determines whether to use `lc_name` as is or create a unique name beginning with the `lc_name` as the prefix | `bool` | `true` | no |
| <a name="input_license_specifications"></a> [license\_specifications](#input\_license\_specifications) | (LT) A list of license specifications to associate with | `map(string)` | `null` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | A list of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use `target_group_arns` instead | `list(string)` | `[]` | no |
| <a name="input_lt_name"></a> [lt\_name](#input\_lt\_name) | Name of launch template to be created | `string` | `""` | no |
| <a name="input_lt_use_name_prefix"></a> [lt\_use\_name\_prefix](#input\_lt\_use\_name\_prefix) | Determines whether to use `lt_name` as is or create a unique name beginning with the `lt_name` as the prefix | `bool` | `true` | no |
| <a name="input_lt_version"></a> [lt\_version](#input\_lt\_version) | Launch template version. Can be version number, `$Latest`, or `$Default` | `string` | `null` | no |
| <a name="input_max_instance_lifetime"></a> [max\_instance\_lifetime](#input\_max\_instance\_lifetime) | The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds | `number` | `null` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the autoscaling group | `number` | `null` | no |
| <a name="input_metadata_options"></a> [metadata\_options](#input\_metadata\_options) | Customize the metadata options for the instance | `map(string)` | `null` | no |
| <a name="input_metrics_granularity"></a> [metrics\_granularity](#input\_metrics\_granularity) | The granularity to associate with the metrics to collect. The only valid value is `1Minute` | `string` | `null` | no |
| <a name="input_min_elb_capacity"></a> [min\_elb\_capacity](#input\_min\_elb\_capacity) | Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes | `number` | `null` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the autoscaling group | `number` | `null` | no |
| <a name="input_mixed_instances_policy"></a> [mixed\_instances\_policy](#input\_mixed\_instances\_policy) | Configuration block containing settings to define launch targets for Auto Scaling groups | `map(any)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name used across the resources created | `string` | n/a | yes |
| <a name="input_network_interfaces"></a> [network\_interfaces](#input\_network\_interfaces) | (LT) Customize network interfaces to be attached at instance boot time | `list(any)` | `[]` | no |
| <a name="input_placement"></a> [placement](#input\_placement) | (LT) The placement of the instance | `map(string)` | `null` | no |
| <a name="input_placement_group"></a> [placement\_group](#input\_placement\_group) | The name of the placement group into which you'll launch your instances, if any | `string` | `null` | no |
| <a name="input_placement_tenancy"></a> [placement\_tenancy](#input\_placement\_tenancy) | (LC) The tenancy of the instance. Valid values are `default` or `dedicated` | `string` | `null` | no |
| <a name="input_protect_from_scale_in"></a> [protect\_from\_scale\_in](#input\_protect\_from\_scale\_in) | Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events. | `bool` | `false` | no |
| <a name="input_ram_disk_id"></a> [ram\_disk\_id](#input\_ram\_disk\_id) | (LT) The ID of the ram disk | `string` | `null` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | (LC) Customize details about the root block device of the instance | `list(map(string))` | `[]` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | A list of security group IDs to associate | `list(string)` | `null` | no |
| <a name="input_service_linked_role_arn"></a> [service\_linked\_role\_arn](#input\_service\_linked\_role\_arn) | The ARN of the service-linked role that the ASG will use to call other AWS services | `string` | `null` | no |
| <a name="input_spot_price"></a> [spot\_price](#input\_spot\_price) | (LC) The maximum price to use for reserving spot instances (defaults to on-demand price) | `string` | `null` | no |
| <a name="input_suspended_processes"></a> [suspended\_processes](#input\_suspended\_processes) | A list of processes to suspend for the Auto Scaling Group. The allowed values are `Launch`, `Terminate`, `HealthCheck`, `ReplaceUnhealthy`, `AZRebalance`, `AlarmNotification`, `ScheduledActions`, `AddToLoadBalancer`. Note that if you suspend either the `Launch` or `Terminate` process types, it can prevent your Auto Scaling Group from functioning properly | `list(string)` | `null` | no |
| <a name="input_tag_specifications"></a> [tag\_specifications](#input\_tag\_specifications) | (LT) The tags to apply to the resources during launch | `list(any)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tag blocks. Each element should have keys named key, value, and propagate\_at\_launch | `list(map(string))` | `[]` | no |
| <a name="input_tags_as_map"></a> [tags\_as\_map](#input\_tags\_as\_map) | A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws\_autoscaling\_group requires. | `map(string)` | `{}` | no |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | A set of `aws_alb_target_group` ARNs, for use with Application or Network Load Balancing | `list(string)` | `[]` | no |
| <a name="input_termination_policies"></a> [termination\_policies](#input\_termination\_policies) | A list of policies to decide how the instances in the Auto Scaling Group should be terminated. The allowed values are `OldestInstance`, `NewestInstance`, `OldestLaunchConfiguration`, `ClosestToNextInstanceHour`, `OldestLaunchTemplate`, `AllocationStrategy`, `Default` | `list(string)` | `null` | no |
| <a name="input_update_default_version"></a> [update\_default\_version](#input\_update\_default\_version) | (LT) Whether to update Default Version each update. Conflicts with `default_version` | `string` | `null` | no |
| <a name="input_use_lc"></a> [use\_lc](#input\_use\_lc) | Determines whether to use a launch configuration in the autoscaling group or not | `bool` | `false` | no |
| <a name="input_use_lt"></a> [use\_lt](#input\_use\_lt) | Determines whether to use a launch template in the autoscaling group or not | `bool` | `false` | no |
| <a name="input_use_name_prefix"></a> [use\_name\_prefix](#input\_use\_name\_prefix) | Determines whether to use `name` as is or create a unique name beginning with the `name` as the prefix | `bool` | `true` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | (LC) The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see `user_data_base64` instead | `string` | `null` | no |
| <a name="input_user_data_base64"></a> [user\_data\_base64](#input\_user\_data\_base64) | The Base64-encoded user data to provide when launching the instance | `string` | `null` | no |
| <a name="input_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#input\_vpc\_zone\_identifier) | A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones` | `list(string)` | `null` | no |
| <a name="input_wait_for_capacity_timeout"></a> [wait\_for\_capacity\_timeout](#input\_wait\_for\_capacity\_timeout) | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior. | `string` | `null` | no |
| <a name="input_wait_for_elb_capacity"></a> [wait\_for\_elb\_capacity](#input\_wait\_for\_elb\_capacity) | Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over `min_elb_capacity` behavior. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_autoscaling_group_availability_zones"></a> [autoscaling\_group\_availability\_zones](#output\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_autoscaling_group_default_cooldown"></a> [autoscaling\_group\_default\_cooldown](#output\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_autoscaling_group_desired_capacity"></a> [autoscaling\_group\_desired\_capacity](#output\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_autoscaling_group_health_check_grace_period"></a> [autoscaling\_group\_health\_check\_grace\_period](#output\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_autoscaling_group_health_check_type"></a> [autoscaling\_group\_health\_check\_type](#output\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_autoscaling_group_id"></a> [autoscaling\_group\_id](#output\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_autoscaling_group_load_balancers"></a> [autoscaling\_group\_load\_balancers](#output\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_autoscaling_group_max_size"></a> [autoscaling\_group\_max\_size](#output\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_autoscaling_group_min_size"></a> [autoscaling\_group\_min\_size](#output\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_autoscaling_group_target_group_arns"></a> [autoscaling\_group\_target\_group\_arns](#output\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_autoscaling_group_vpc_zone_identifier"></a> [autoscaling\_group\_vpc\_zone\_identifier](#output\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_launch_configuration_arn"></a> [launch\_configuration\_arn](#output\_launch\_configuration\_arn) | The ARN of the launch configuration |
| <a name="output_launch_configuration_id"></a> [launch\_configuration\_id](#output\_launch\_configuration\_id) | The ID of the launch configuration |
| <a name="output_launch_configuration_name"></a> [launch\_configuration\_name](#output\_launch\_configuration\_name) | The name of the launch configuration |
| <a name="output_launch_template_arn"></a> [launch\_template\_arn](#output\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_launch_template_id"></a> [launch\_template\_id](#output\_launch\_template\_id) | The ID of the launch template |
| <a name="output_launch_template_latest_version"></a> [launch\_template\_latest\_version](#output\_launch\_template\_latest\_version) | The latest version of the launch template |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [Anton Babenko](https://github.com/antonbabenko).

Thanks to [Jamie-BitFlight](https://github.com/Jamie-BitFlight) who added possibility to specify unlimited numbers of tags.

## License

Apache 2 Licensed. See LICENSE for full details.
