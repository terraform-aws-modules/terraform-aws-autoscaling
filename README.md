# AWS Auto Scaling Group (ASG) Terraform module

Terraform module which creates Auto Scaling resources on AWS.

These types of resources are supported:

* [Launch Configuration](https://www.terraform.io/docs/providers/aws/r/launch_configuration.html)
* [Auto Scaling Group](https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html)

## Terraform versions

Terraform 0.12. Pin module version to `~> v3.0`. Submit pull-requests to `master` branch.

Terraform 0.11. Pin module version to `~> v2.0`. Submit pull-requests to `terraform011` branch.

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
| terraform | >= 0.12.6, < 0.14 |
| aws | >= 2.41, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.41, < 4.0 |
| null | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| asg\_name | Creates a unique name for autoscaling group beginning with the specified prefix | `string` | `""` | no |
| associate\_public\_ip\_address | Associate a public ip address with an instance in a VPC | `bool` | `false` | no |
| create\_asg | Whether to create autoscaling group | `bool` | `true` | no |
| create\_asg\_with\_initial\_lifecycle\_hook | Create an ASG with initial lifecycle hook | `bool` | `false` | no |
| create\_lc | Whether to create launch configuration | `bool` | `true` | no |
| default\_cooldown | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start | `number` | `300` | no |
| desired\_capacity | The number of Amazon EC2 instances that should be running in the group | `string` | n/a | yes |
| ebs\_block\_device | Additional EBS block devices to attach to the instance | `list(map(string))` | `[]` | no |
| ebs\_optimized | If true, the launched EC2 instance will be EBS-optimized | `bool` | `false` | no |
| enable\_monitoring | Enables/disables detailed monitoring. This is enabled by default. | `bool` | `true` | no |
| enabled\_metrics | A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances | `list(string)` | <pre>[<br>  "GroupMinSize",<br>  "GroupMaxSize",<br>  "GroupDesiredCapacity",<br>  "GroupInServiceInstances",<br>  "GroupPendingInstances",<br>  "GroupStandbyInstances",<br>  "GroupTerminatingInstances",<br>  "GroupTotalInstances"<br>]</pre> | no |
| ephemeral\_block\_device | Customize Ephemeral (also known as 'Instance Store') volumes on the instance | `list(map(string))` | `[]` | no |
| force\_delete | Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling | `bool` | `false` | no |
| health\_check\_grace\_period | Time (in seconds) after instance comes into service before checking health | `number` | `300` | no |
| health\_check\_type | Controls how health checking is done. Values are - EC2 and ELB | `string` | n/a | yes |
| iam\_instance\_profile | The IAM instance profile to associate with launched instances | `string` | `""` | no |
| image\_id | The EC2 image ID to launch | `string` | `""` | no |
| initial\_lifecycle\_hook\_default\_result | Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The value for this parameter can be either CONTINUE or ABANDON | `string` | `"ABANDON"` | no |
| initial\_lifecycle\_hook\_heartbeat\_timeout | Defines the amount of time, in seconds, that can elapse before the lifecycle hook times out. When the lifecycle hook times out, Auto Scaling performs the action defined in the DefaultResult parameter | `string` | `"60"` | no |
| initial\_lifecycle\_hook\_lifecycle\_transition | The instance state to which you want to attach the initial lifecycle hook | `string` | `""` | no |
| initial\_lifecycle\_hook\_name | The name of initial lifecycle hook | `string` | `""` | no |
| initial\_lifecycle\_hook\_notification\_metadata | Contains additional information that you want to include any time Auto Scaling sends a message to the notification target | `string` | `""` | no |
| initial\_lifecycle\_hook\_notification\_target\_arn | The ARN of the notification target that Auto Scaling will use to notify you when an instance is in the transition state for the lifecycle hook. This ARN target can be either an SQS queue or an SNS topic | `string` | `""` | no |
| initial\_lifecycle\_hook\_role\_arn | The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target | `string` | `""` | no |
| instance\_type | The size of instance to launch | `string` | `""` | no |
| key\_name | The key name that should be used for the instance | `string` | `""` | no |
| launch\_configuration | The name of the launch configuration to use (if it is created outside of this module) | `string` | `""` | no |
| lc\_name | Creates a unique name for launch configuration beginning with the specified prefix | `string` | `""` | no |
| load\_balancers | A list of elastic load balancer names to add to the autoscaling group names | `list(string)` | `[]` | no |
| max\_instance\_lifetime | The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds. | `number` | `0` | no |
| max\_size | The maximum size of the auto scale group | `string` | n/a | yes |
| metrics\_granularity | The granularity to associate with the metrics to collect. The only valid value is 1Minute | `string` | `"1Minute"` | no |
| min\_elb\_capacity | Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes | `number` | `0` | no |
| min\_size | The minimum size of the auto scale group | `string` | n/a | yes |
| name | Creates a unique name beginning with the specified prefix | `string` | n/a | yes |
| placement\_group | The name of the placement group into which you'll launch your instances, if any | `string` | `""` | no |
| placement\_tenancy | The tenancy of the instance. Valid values are 'default' or 'dedicated' | `string` | `"default"` | no |
| protect\_from\_scale\_in | Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events. | `bool` | `false` | no |
| recreate\_asg\_when\_lc\_changes | Whether to recreate an autoscaling group when launch configuration changes | `bool` | `false` | no |
| root\_block\_device | Customize details about the root block device of the instance | `list(map(string))` | `[]` | no |
| security\_groups | A list of security group IDs to assign to the launch configuration | `list(string)` | `[]` | no |
| service\_linked\_role\_arn | The ARN of the service-linked role that the ASG will use to call other AWS services. | `string` | `""` | no |
| spot\_price | The price to use for reserving spot instances | `string` | `""` | no |
| suspended\_processes | A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly. | `list(string)` | `[]` | no |
| tags | A list of tag blocks. Each element should have keys named key, value, and propagate\_at\_launch. | `list(map(string))` | `[]` | no |
| tags\_as\_map | A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws\_autoscaling\_group requires. | `map(string)` | `{}` | no |
| target\_group\_arns | A list of aws\_alb\_target\_group ARNs, for use with Application Load Balancing | `list(string)` | `[]` | no |
| termination\_policies | A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default | `list(string)` | <pre>[<br>  "Default"<br>]</pre> | no |
| user\_data | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user\_data\_base64 instead. | `string` | `null` | no |
| user\_data\_base64 | Can be used instead of user\_data to pass base64-encoded binary data directly. Use this instead of user\_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption. | `string` | `null` | no |
| vpc\_zone\_identifier | A list of subnet IDs to launch resources in | `list(string)` | n/a | yes |
| wait\_for\_capacity\_timeout | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior. | `string` | `"10m"` | no |
| wait\_for\_elb\_capacity | Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min\_elb\_capacity behavior. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_autoscaling\_group\_arn | The ARN for this AutoScaling Group |
| this\_autoscaling\_group\_availability\_zones | The availability zones of the autoscale group |
| this\_autoscaling\_group\_default\_cooldown | Time between a scaling activity and the succeeding scaling activity |
| this\_autoscaling\_group\_desired\_capacity | The number of Amazon EC2 instances that should be running in the group |
| this\_autoscaling\_group\_health\_check\_grace\_period | Time after instance comes into service before checking health |
| this\_autoscaling\_group\_health\_check\_type | EC2 or ELB. Controls how health checking is done |
| this\_autoscaling\_group\_id | The autoscaling group id |
| this\_autoscaling\_group\_load\_balancers | The load balancer names associated with the autoscaling group |
| this\_autoscaling\_group\_max\_size | The maximum size of the autoscale group |
| this\_autoscaling\_group\_min\_size | The minimum size of the autoscale group |
| this\_autoscaling\_group\_name | The autoscaling group name |
| this\_autoscaling\_group\_target\_group\_arns | List of Target Group ARNs that apply to this AutoScaling Group |
| this\_autoscaling\_group\_vpc\_zone\_identifier | The VPC zone identifier |
| this\_launch\_configuration\_id | The ID of the launch configuration |
| this\_launch\_configuration\_name | The name of the launch configuration |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [Anton Babenko](https://github.com/antonbabenko).

Thanks to [Jamie-BitFlight](https://github.com/Jamie-BitFlight) who added possibility to specify unlimited numbers of tags.

## License

Apache 2 Licensed. See LICENSE for full details.
