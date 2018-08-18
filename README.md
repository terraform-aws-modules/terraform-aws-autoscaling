# AWS Auto Scaling Group (ASG) Terraform module

Terraform module which creates Auto Scaling resources on AWS.

These types of resources are supported:

* [Launch Configuration](https://www.terraform.io/docs/providers/aws/r/launch_configuration.html)
* [Auto Scaling Group](https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html)

## Usage

```hcl
module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

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

1. To disable creation of both resources (LC and ASG) you can specify both arguments `create_lc = false` and `create_asg = false`. Sometimes you need to use this way to create resources in modules conditionally but Terraform does not allow to use `count` inside `module` block.

## Tags

There are two ways to specify tags for auto-scaling group in this module - `tags` and `tags_as_map`. See [examples/asg_ec2/main.tf](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/blob/master/examples/asg_ec2/main.tf) for example.

## Examples

* [Auto Scaling Group without ELB](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/asg_ec2)
* [Auto Scaling Group with ELB](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/asg_elb)
* [Auto Scaling Group with external Launch Configuration](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/asg_ec2_external_launch_configuration)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| asg_name | Creates a unique name for autoscaling group beginning with the specified prefix | string | `` | no |
| associate_public_ip_address | Associate a public ip address with an instance in a VPC | string | `false` | no |
| create_asg | Whether to create autoscaling group | string | `true` | no |
| create_lc | Whether to create launch configuration | string | `true` | no |
| default_cooldown | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start | string | `300` | no |
| desired_capacity | The number of Amazon EC2 instances that should be running in the group | string | - | yes |
| ebs_block_device | Additional EBS block devices to attach to the instance | list | `<list>` | no |
| ebs_optimized | If true, the launched EC2 instance will be EBS-optimized | string | `false` | no |
| enable_monitoring | Enables/disables detailed monitoring. This is enabled by default. | string | `true` | no |
| enabled_metrics | A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances | list | `<list>` | no |
| ephemeral_block_device | Customize Ephemeral (also known as 'Instance Store') volumes on the instance | list | `<list>` | no |
| force_delete | Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling | string | `false` | no |
| health_check_grace_period | Time (in seconds) after instance comes into service before checking health | string | `300` | no |
| health_check_type | Controls how health checking is done. Values are - EC2 and ELB | string | - | yes |
| iam_instance_profile | The IAM instance profile to associate with launched instances | string | `` | no |
| image_id | The EC2 image ID to launch | string | `` | no |
| instance_type | The size of instance to launch | string | `` | no |
| key_name | The key name that should be used for the instance | string | `` | no |
| launch_configuration | The name of the launch configuration to use (if it is created outside of this module) | string | `` | no |
| lc_name | Creates a unique name for launch configuration beginning with the specified prefix | string | `` | no |
| load_balancers | A list of elastic load balancer names to add to the autoscaling group names | string | `<list>` | no |
| max_size | The maximum size of the auto scale group | string | - | yes |
| metrics_granularity | The granularity to associate with the metrics to collect. The only valid value is 1Minute | string | `1Minute` | no |
| min_elb_capacity | Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes | string | `0` | no |
| min_size | The minimum size of the auto scale group | string | - | yes |
| name | Creates a unique name beginning with the specified prefix | string | - | yes |
| placement_group | The name of the placement group into which you'll launch your instances, if any | string | `` | no |
| placement_tenancy | The tenancy of the instance. Valid values are 'default' or 'dedicated' | string | `default` | no |
| protect_from_scale_in | Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events. | string | `false` | no |
| recreate_asg_when_lc_changes | Whether to recreate an autoscaling group when launch configuration changes | string | `false` | no |
| root_block_device | Customize details about the root block device of the instance | list | `<list>` | no |
| security_groups | A list of security group IDs to assign to the launch configuration | list | `<list>` | no |
| spot_price | The price to use for reserving spot instances | string | `` | no |
| suspended_processes | A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly. | string | `<list>` | no |
| tags | A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch. | string | `<list>` | no |
| tags_as_map | A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws_autoscaling_group requires. | map | `<map>` | no |
| target_group_arns | A list of aws_alb_target_group ARNs, for use with Application Load Balancing | string | `<list>` | no |
| termination_policies | A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default | list | `<list>` | no |
| user_data | The user data to provide when launching the instance | string | ` ` | no |
| vpc_zone_identifier | A list of subnet IDs to launch resources in | list | - | yes |
| wait_for_capacity_timeout | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior. | string | `10m` | no |
| wait_for_elb_capacity | Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior. | string | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| this_autoscaling_group_arn | The ARN for this AutoScaling Group |
| this_autoscaling_group_default_cooldown | Time between a scaling activity and the succeeding scaling activity |
| this_autoscaling_group_desired_capacity | The number of Amazon EC2 instances that should be running in the group |
| this_autoscaling_group_health_check_grace_period | Time after instance comes into service before checking health |
| this_autoscaling_group_health_check_type | EC2 or ELB. Controls how health checking is done |
| this_autoscaling_group_id | The autoscaling group id |
| this_autoscaling_group_max_size | The maximum size of the autoscale group |
| this_autoscaling_group_min_size | The minimum size of the autoscale group |
| this_autoscaling_group_name | The autoscaling group name |
| this_launch_configuration_id | The ID of the launch configuration |
| this_launch_configuration_name | The name of the launch configuration |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [Anton Babenko](https://github.com/antonbabenko).

Thanks to [Jamie-BitFlight](https://github.com/Jamie-BitFlight) who added possibility to specify unlimited numbers of tags.

## License

Apache 2 Licensed. See LICENSE for full details.
