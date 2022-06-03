# Complete Auto Scaling Group

Configuration in this directory creates several different variations of resources for autoscaling groups and launch templates.

There are primarily six different setups shown in this example project:
- `disabled` - demonstrates how to completely disable creation of both the autoscaling group and the associated launch template (no resources will be created)
- `template only` - demonstrates how to create a launch template without creating an autoscaling group
- `default` - demonstrates the bare minimum amount of information required to create an autoscaling group, relying mostly on default values
- `external` - demonstrates how to create an autoscaling group using an externally created launch template
- `complete` - demonstrates the vast majority of the functionality available for creating an autoscaling group
- `mixed instance` - demonstrates how to create an autoscaling group configured to use a mixed instance policy
- `warm pool` - demonstrates the usage of warm pools with capacity reservations
- `efa` - demonstrates the usage of EFA (Elastic Fabric Adapter) type network interfaces

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.14 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | ~> 6.0 |
| <a name="module_alb_http_sg"></a> [alb\_http\_sg](#module\_alb\_http\_sg) | terraform-aws-modules/security-group/aws//modules/http-80 | ~> 4.0 |
| <a name="module_asg_sg"></a> [asg\_sg](#module\_asg\_sg) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_complete"></a> [complete](#module\_complete) | ../../ | n/a |
| <a name="module_default"></a> [default](#module\_default) | ../../ | n/a |
| <a name="module_disabled"></a> [disabled](#module\_disabled) | ../../ | n/a |
| <a name="module_efa"></a> [efa](#module\_efa) | ../../ | n/a |
| <a name="module_external"></a> [external](#module\_external) | ../../ | n/a |
| <a name="module_instance_requirements"></a> [instance\_requirements](#module\_instance\_requirements) | ../../ | n/a |
| <a name="module_instance_requirements_accelerators"></a> [instance\_requirements\_accelerators](#module\_instance\_requirements\_accelerators) | ../../ | n/a |
| <a name="module_launch_template_only"></a> [launch\_template\_only](#module\_launch\_template\_only) | ../../ | n/a |
| <a name="module_mixed_instance"></a> [mixed\_instance](#module\_mixed\_instance) | ../../ | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |
| <a name="module_warm_pool"></a> [warm\_pool](#module\_warm\_pool) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_capacity_reservation.targeted](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_capacity_reservation) | resource |
| [aws_iam_instance_profile.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_service_linked_role.autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_complete_autoscaling_group_arn"></a> [complete\_autoscaling\_group\_arn](#output\_complete\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_complete_autoscaling_group_availability_zones"></a> [complete\_autoscaling\_group\_availability\_zones](#output\_complete\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_complete_autoscaling_group_default_cooldown"></a> [complete\_autoscaling\_group\_default\_cooldown](#output\_complete\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_complete_autoscaling_group_desired_capacity"></a> [complete\_autoscaling\_group\_desired\_capacity](#output\_complete\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_complete_autoscaling_group_enabled_metrics"></a> [complete\_autoscaling\_group\_enabled\_metrics](#output\_complete\_autoscaling\_group\_enabled\_metrics) | List of metrics enabled for collection |
| <a name="output_complete_autoscaling_group_health_check_grace_period"></a> [complete\_autoscaling\_group\_health\_check\_grace\_period](#output\_complete\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_complete_autoscaling_group_health_check_type"></a> [complete\_autoscaling\_group\_health\_check\_type](#output\_complete\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_complete_autoscaling_group_id"></a> [complete\_autoscaling\_group\_id](#output\_complete\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_complete_autoscaling_group_load_balancers"></a> [complete\_autoscaling\_group\_load\_balancers](#output\_complete\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_complete_autoscaling_group_max_size"></a> [complete\_autoscaling\_group\_max\_size](#output\_complete\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_complete_autoscaling_group_min_size"></a> [complete\_autoscaling\_group\_min\_size](#output\_complete\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_complete_autoscaling_group_name"></a> [complete\_autoscaling\_group\_name](#output\_complete\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_complete_autoscaling_group_target_group_arns"></a> [complete\_autoscaling\_group\_target\_group\_arns](#output\_complete\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_complete_autoscaling_group_vpc_zone_identifier"></a> [complete\_autoscaling\_group\_vpc\_zone\_identifier](#output\_complete\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_complete_autoscaling_policy_arns"></a> [complete\_autoscaling\_policy\_arns](#output\_complete\_autoscaling\_policy\_arns) | ARNs of autoscaling policies |
| <a name="output_complete_autoscaling_schedule_arns"></a> [complete\_autoscaling\_schedule\_arns](#output\_complete\_autoscaling\_schedule\_arns) | ARNs of autoscaling group schedules |
| <a name="output_complete_iam_instance_profile_arn"></a> [complete\_iam\_instance\_profile\_arn](#output\_complete\_iam\_instance\_profile\_arn) | ARN assigned by AWS to the instance profile |
| <a name="output_complete_iam_instance_profile_id"></a> [complete\_iam\_instance\_profile\_id](#output\_complete\_iam\_instance\_profile\_id) | Instance profile's ID |
| <a name="output_complete_iam_instance_profile_unique"></a> [complete\_iam\_instance\_profile\_unique](#output\_complete\_iam\_instance\_profile\_unique) | Stable and unique string identifying the IAM instance profile |
| <a name="output_complete_iam_role_arn"></a> [complete\_iam\_role\_arn](#output\_complete\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_complete_iam_role_name"></a> [complete\_iam\_role\_name](#output\_complete\_iam\_role\_name) | The name of the IAM role |
| <a name="output_complete_iam_role_unique_id"></a> [complete\_iam\_role\_unique\_id](#output\_complete\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_complete_launch_template_arn"></a> [complete\_launch\_template\_arn](#output\_complete\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_complete_launch_template_default_version"></a> [complete\_launch\_template\_default\_version](#output\_complete\_launch\_template\_default\_version) | The default version of the launch template |
| <a name="output_complete_launch_template_id"></a> [complete\_launch\_template\_id](#output\_complete\_launch\_template\_id) | The ID of the launch template |
| <a name="output_complete_launch_template_latest_version"></a> [complete\_launch\_template\_latest\_version](#output\_complete\_launch\_template\_latest\_version) | The latest version of the launch template |
| <a name="output_complete_launch_template_name"></a> [complete\_launch\_template\_name](#output\_complete\_launch\_template\_name) | The name of the launch template |
| <a name="output_default_autoscaling_group_arn"></a> [default\_autoscaling\_group\_arn](#output\_default\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_default_autoscaling_group_availability_zones"></a> [default\_autoscaling\_group\_availability\_zones](#output\_default\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_default_autoscaling_group_default_cooldown"></a> [default\_autoscaling\_group\_default\_cooldown](#output\_default\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_default_autoscaling_group_desired_capacity"></a> [default\_autoscaling\_group\_desired\_capacity](#output\_default\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_default_autoscaling_group_enabled_metrics"></a> [default\_autoscaling\_group\_enabled\_metrics](#output\_default\_autoscaling\_group\_enabled\_metrics) | List of metrics enabled for collection |
| <a name="output_default_autoscaling_group_health_check_grace_period"></a> [default\_autoscaling\_group\_health\_check\_grace\_period](#output\_default\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_default_autoscaling_group_health_check_type"></a> [default\_autoscaling\_group\_health\_check\_type](#output\_default\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_default_autoscaling_group_id"></a> [default\_autoscaling\_group\_id](#output\_default\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_default_autoscaling_group_load_balancers"></a> [default\_autoscaling\_group\_load\_balancers](#output\_default\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_default_autoscaling_group_max_size"></a> [default\_autoscaling\_group\_max\_size](#output\_default\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_default_autoscaling_group_min_size"></a> [default\_autoscaling\_group\_min\_size](#output\_default\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_default_autoscaling_group_name"></a> [default\_autoscaling\_group\_name](#output\_default\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_default_autoscaling_group_target_group_arns"></a> [default\_autoscaling\_group\_target\_group\_arns](#output\_default\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_default_autoscaling_group_vpc_zone_identifier"></a> [default\_autoscaling\_group\_vpc\_zone\_identifier](#output\_default\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_default_iam_instance_profile_arn"></a> [default\_iam\_instance\_profile\_arn](#output\_default\_iam\_instance\_profile\_arn) | ARN assigned by AWS to the instance profile |
| <a name="output_default_iam_instance_profile_id"></a> [default\_iam\_instance\_profile\_id](#output\_default\_iam\_instance\_profile\_id) | Instance profile's ID |
| <a name="output_default_iam_instance_profile_unique"></a> [default\_iam\_instance\_profile\_unique](#output\_default\_iam\_instance\_profile\_unique) | Stable and unique string identifying the IAM instance profile |
| <a name="output_default_iam_role_arn"></a> [default\_iam\_role\_arn](#output\_default\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_default_iam_role_name"></a> [default\_iam\_role\_name](#output\_default\_iam\_role\_name) | The name of the IAM role |
| <a name="output_default_iam_role_unique_id"></a> [default\_iam\_role\_unique\_id](#output\_default\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_default_launch_template_arn"></a> [default\_launch\_template\_arn](#output\_default\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_default_launch_template_default_version"></a> [default\_launch\_template\_default\_version](#output\_default\_launch\_template\_default\_version) | The default version of the launch template |
| <a name="output_default_launch_template_id"></a> [default\_launch\_template\_id](#output\_default\_launch\_template\_id) | The ID of the launch template |
| <a name="output_default_launch_template_latest_version"></a> [default\_launch\_template\_latest\_version](#output\_default\_launch\_template\_latest\_version) | The latest version of the launch template |
| <a name="output_default_launch_template_name"></a> [default\_launch\_template\_name](#output\_default\_launch\_template\_name) | The name of the launch template |
| <a name="output_external_autoscaling_group_arn"></a> [external\_autoscaling\_group\_arn](#output\_external\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_external_autoscaling_group_availability_zones"></a> [external\_autoscaling\_group\_availability\_zones](#output\_external\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_external_autoscaling_group_default_cooldown"></a> [external\_autoscaling\_group\_default\_cooldown](#output\_external\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_external_autoscaling_group_desired_capacity"></a> [external\_autoscaling\_group\_desired\_capacity](#output\_external\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_external_autoscaling_group_enabled_metrics"></a> [external\_autoscaling\_group\_enabled\_metrics](#output\_external\_autoscaling\_group\_enabled\_metrics) | List of metrics enabled for collection |
| <a name="output_external_autoscaling_group_health_check_grace_period"></a> [external\_autoscaling\_group\_health\_check\_grace\_period](#output\_external\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_external_autoscaling_group_health_check_type"></a> [external\_autoscaling\_group\_health\_check\_type](#output\_external\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_external_autoscaling_group_id"></a> [external\_autoscaling\_group\_id](#output\_external\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_external_autoscaling_group_load_balancers"></a> [external\_autoscaling\_group\_load\_balancers](#output\_external\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_external_autoscaling_group_max_size"></a> [external\_autoscaling\_group\_max\_size](#output\_external\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_external_autoscaling_group_min_size"></a> [external\_autoscaling\_group\_min\_size](#output\_external\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_external_autoscaling_group_name"></a> [external\_autoscaling\_group\_name](#output\_external\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_external_autoscaling_group_target_group_arns"></a> [external\_autoscaling\_group\_target\_group\_arns](#output\_external\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_external_autoscaling_group_vpc_zone_identifier"></a> [external\_autoscaling\_group\_vpc\_zone\_identifier](#output\_external\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_external_iam_instance_profile_arn"></a> [external\_iam\_instance\_profile\_arn](#output\_external\_iam\_instance\_profile\_arn) | ARN assigned by AWS to the instance profile |
| <a name="output_external_iam_instance_profile_id"></a> [external\_iam\_instance\_profile\_id](#output\_external\_iam\_instance\_profile\_id) | Instance profile's ID |
| <a name="output_external_iam_instance_profile_unique"></a> [external\_iam\_instance\_profile\_unique](#output\_external\_iam\_instance\_profile\_unique) | Stable and unique string identifying the IAM instance profile |
| <a name="output_external_iam_role_arn"></a> [external\_iam\_role\_arn](#output\_external\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_external_iam_role_name"></a> [external\_iam\_role\_name](#output\_external\_iam\_role\_name) | The name of the IAM role |
| <a name="output_external_iam_role_unique_id"></a> [external\_iam\_role\_unique\_id](#output\_external\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_external_launch_template_arn"></a> [external\_launch\_template\_arn](#output\_external\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_external_launch_template_default_version"></a> [external\_launch\_template\_default\_version](#output\_external\_launch\_template\_default\_version) | The default version of the launch template |
| <a name="output_external_launch_template_id"></a> [external\_launch\_template\_id](#output\_external\_launch\_template\_id) | The ID of the launch template |
| <a name="output_external_launch_template_latest_version"></a> [external\_launch\_template\_latest\_version](#output\_external\_launch\_template\_latest\_version) | The latest version of the launch template |
| <a name="output_external_launch_template_name"></a> [external\_launch\_template\_name](#output\_external\_launch\_template\_name) | The name of the launch template |
| <a name="output_launch_template_only_launch_template_arn"></a> [launch\_template\_only\_launch\_template\_arn](#output\_launch\_template\_only\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_launch_template_only_launch_template_default_version"></a> [launch\_template\_only\_launch\_template\_default\_version](#output\_launch\_template\_only\_launch\_template\_default\_version) | The default version of the launch template |
| <a name="output_launch_template_only_launch_template_id"></a> [launch\_template\_only\_launch\_template\_id](#output\_launch\_template\_only\_launch\_template\_id) | The ID of the launch template |
| <a name="output_launch_template_only_launch_template_latest_version"></a> [launch\_template\_only\_launch\_template\_latest\_version](#output\_launch\_template\_only\_launch\_template\_latest\_version) | The latest version of the launch template |
| <a name="output_launch_template_only_launch_template_name"></a> [launch\_template\_only\_launch\_template\_name](#output\_launch\_template\_only\_launch\_template\_name) | The name of the launch template |
| <a name="output_mixed_instance_autoscaling_group_arn"></a> [mixed\_instance\_autoscaling\_group\_arn](#output\_mixed\_instance\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_mixed_instance_autoscaling_group_availability_zones"></a> [mixed\_instance\_autoscaling\_group\_availability\_zones](#output\_mixed\_instance\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_mixed_instance_autoscaling_group_default_cooldown"></a> [mixed\_instance\_autoscaling\_group\_default\_cooldown](#output\_mixed\_instance\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_mixed_instance_autoscaling_group_desired_capacity"></a> [mixed\_instance\_autoscaling\_group\_desired\_capacity](#output\_mixed\_instance\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_mixed_instance_autoscaling_group_enabled_metrics"></a> [mixed\_instance\_autoscaling\_group\_enabled\_metrics](#output\_mixed\_instance\_autoscaling\_group\_enabled\_metrics) | List of metrics enabled for collection |
| <a name="output_mixed_instance_autoscaling_group_health_check_grace_period"></a> [mixed\_instance\_autoscaling\_group\_health\_check\_grace\_period](#output\_mixed\_instance\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_mixed_instance_autoscaling_group_health_check_type"></a> [mixed\_instance\_autoscaling\_group\_health\_check\_type](#output\_mixed\_instance\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_mixed_instance_autoscaling_group_id"></a> [mixed\_instance\_autoscaling\_group\_id](#output\_mixed\_instance\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_mixed_instance_autoscaling_group_load_balancers"></a> [mixed\_instance\_autoscaling\_group\_load\_balancers](#output\_mixed\_instance\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_mixed_instance_autoscaling_group_max_size"></a> [mixed\_instance\_autoscaling\_group\_max\_size](#output\_mixed\_instance\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_mixed_instance_autoscaling_group_min_size"></a> [mixed\_instance\_autoscaling\_group\_min\_size](#output\_mixed\_instance\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_mixed_instance_autoscaling_group_name"></a> [mixed\_instance\_autoscaling\_group\_name](#output\_mixed\_instance\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_mixed_instance_autoscaling_group_target_group_arns"></a> [mixed\_instance\_autoscaling\_group\_target\_group\_arns](#output\_mixed\_instance\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_mixed_instance_autoscaling_group_vpc_zone_identifier"></a> [mixed\_instance\_autoscaling\_group\_vpc\_zone\_identifier](#output\_mixed\_instance\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_mixed_instance_iam_instance_profile_arn"></a> [mixed\_instance\_iam\_instance\_profile\_arn](#output\_mixed\_instance\_iam\_instance\_profile\_arn) | ARN assigned by AWS to the instance profile |
| <a name="output_mixed_instance_iam_instance_profile_id"></a> [mixed\_instance\_iam\_instance\_profile\_id](#output\_mixed\_instance\_iam\_instance\_profile\_id) | Instance profile's ID |
| <a name="output_mixed_instance_iam_instance_profile_unique"></a> [mixed\_instance\_iam\_instance\_profile\_unique](#output\_mixed\_instance\_iam\_instance\_profile\_unique) | Stable and unique string identifying the IAM instance profile |
| <a name="output_mixed_instance_iam_role_arn"></a> [mixed\_instance\_iam\_role\_arn](#output\_mixed\_instance\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_mixed_instance_iam_role_name"></a> [mixed\_instance\_iam\_role\_name](#output\_mixed\_instance\_iam\_role\_name) | The name of the IAM role |
| <a name="output_mixed_instance_iam_role_unique_id"></a> [mixed\_instance\_iam\_role\_unique\_id](#output\_mixed\_instance\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_mixed_instance_launch_template_arn"></a> [mixed\_instance\_launch\_template\_arn](#output\_mixed\_instance\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_mixed_instance_launch_template_default_version"></a> [mixed\_instance\_launch\_template\_default\_version](#output\_mixed\_instance\_launch\_template\_default\_version) | The default version of the launch template |
| <a name="output_mixed_instance_launch_template_id"></a> [mixed\_instance\_launch\_template\_id](#output\_mixed\_instance\_launch\_template\_id) | The ID of the launch template |
| <a name="output_mixed_instance_launch_template_latest_version"></a> [mixed\_instance\_launch\_template\_latest\_version](#output\_mixed\_instance\_launch\_template\_latest\_version) | The latest version of the launch template |
| <a name="output_mixed_instance_launch_template_name"></a> [mixed\_instance\_launch\_template\_name](#output\_mixed\_instance\_launch\_template\_name) | The name of the launch template |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
