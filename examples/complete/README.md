# Complete Auto Scaling Group

Configuration in this directory creates several different variations of resources for autoscaling groups, launch templates, and launch configurations.

Note: the term configuration file is used to describe either the launch template or launch configuration. For most of the examples detailed below, examples are provided for using a launch configuration file as well as a launch template file (save for `disabled` and `mixed instance`)

There are primarily six different setups shown in this example project:
- `disabled` - demonstrates how to completely disable creation of both the autoscaling group and the associated configuration file (no resources will be created)
- `config only` - demonstrates how to create a configuration file only (launch template or launch configuration) without creating an autoscaling group
- `default` - demonstrates the bare minimum amount of information required to create an autoscaling group using a configuration file, relying mostly on default values
- `external` - demonstrates how to create an autoscaling group using an externally created configuration file
- `complete` - demonstrates the vast majority of the functionality available for creating an autoscaling group using a configuration file
- `mixed instance` - demonstrates how to create an autoscaling group using a launch template configured to use a mixed instance policy

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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.30 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.30 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | ~> 6.0 |
| <a name="module_alb_http_sg"></a> [alb\_http\_sg](#module\_alb\_http\_sg) | terraform-aws-modules/security-group/aws//modules/http-80 | ~> 4.0 |
| <a name="module_asg_sg"></a> [asg\_sg](#module\_asg\_sg) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_complete_lc"></a> [complete\_lc](#module\_complete\_lc) | ../../ |  |
| <a name="module_complete_lt"></a> [complete\_lt](#module\_complete\_lt) | ../../ |  |
| <a name="module_default_lc"></a> [default\_lc](#module\_default\_lc) | ../../ |  |
| <a name="module_default_lt"></a> [default\_lt](#module\_default\_lt) | ../../ |  |
| <a name="module_disabled"></a> [disabled](#module\_disabled) | ../../ |  |
| <a name="module_external_lc"></a> [external\_lc](#module\_external\_lc) | ../../ |  |
| <a name="module_external_lt"></a> [external\_lt](#module\_external\_lt) | ../../ |  |
| <a name="module_lc_only"></a> [lc\_only](#module\_lc\_only) | ../../ |  |
| <a name="module_lt_only"></a> [lt\_only](#module\_lt\_only) | ../../ |  |
| <a name="module_mixed_instance"></a> [mixed\_instance](#module\_mixed\_instance) | ../../ |  |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_service_linked_role.autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_launch_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_complete_lc_autoscaling_group_arn"></a> [complete\_lc\_autoscaling\_group\_arn](#output\_complete\_lc\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_complete_lc_autoscaling_group_availability_zones"></a> [complete\_lc\_autoscaling\_group\_availability\_zones](#output\_complete\_lc\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_complete_lc_autoscaling_group_default_cooldown"></a> [complete\_lc\_autoscaling\_group\_default\_cooldown](#output\_complete\_lc\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_complete_lc_autoscaling_group_desired_capacity"></a> [complete\_lc\_autoscaling\_group\_desired\_capacity](#output\_complete\_lc\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_complete_lc_autoscaling_group_health_check_grace_period"></a> [complete\_lc\_autoscaling\_group\_health\_check\_grace\_period](#output\_complete\_lc\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_complete_lc_autoscaling_group_health_check_type"></a> [complete\_lc\_autoscaling\_group\_health\_check\_type](#output\_complete\_lc\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_complete_lc_autoscaling_group_id"></a> [complete\_lc\_autoscaling\_group\_id](#output\_complete\_lc\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_complete_lc_autoscaling_group_load_balancers"></a> [complete\_lc\_autoscaling\_group\_load\_balancers](#output\_complete\_lc\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_complete_lc_autoscaling_group_max_size"></a> [complete\_lc\_autoscaling\_group\_max\_size](#output\_complete\_lc\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_complete_lc_autoscaling_group_min_size"></a> [complete\_lc\_autoscaling\_group\_min\_size](#output\_complete\_lc\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_complete_lc_autoscaling_group_name"></a> [complete\_lc\_autoscaling\_group\_name](#output\_complete\_lc\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_complete_lc_autoscaling_group_target_group_arns"></a> [complete\_lc\_autoscaling\_group\_target\_group\_arns](#output\_complete\_lc\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_complete_lc_autoscaling_group_vpc_zone_identifier"></a> [complete\_lc\_autoscaling\_group\_vpc\_zone\_identifier](#output\_complete\_lc\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_complete_lc_launch_configuration_arn"></a> [complete\_lc\_launch\_configuration\_arn](#output\_complete\_lc\_launch\_configuration\_arn) | The ARN of the launch configuration |
| <a name="output_complete_lc_launch_configuration_id"></a> [complete\_lc\_launch\_configuration\_id](#output\_complete\_lc\_launch\_configuration\_id) | The ID of the launch configuration |
| <a name="output_complete_lc_launch_configuration_name"></a> [complete\_lc\_launch\_configuration\_name](#output\_complete\_lc\_launch\_configuration\_name) | The name of the launch configuration |
| <a name="output_complete_lt_autoscaling_group_arn"></a> [complete\_lt\_autoscaling\_group\_arn](#output\_complete\_lt\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_complete_lt_autoscaling_group_availability_zones"></a> [complete\_lt\_autoscaling\_group\_availability\_zones](#output\_complete\_lt\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_complete_lt_autoscaling_group_default_cooldown"></a> [complete\_lt\_autoscaling\_group\_default\_cooldown](#output\_complete\_lt\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_complete_lt_autoscaling_group_desired_capacity"></a> [complete\_lt\_autoscaling\_group\_desired\_capacity](#output\_complete\_lt\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_complete_lt_autoscaling_group_health_check_grace_period"></a> [complete\_lt\_autoscaling\_group\_health\_check\_grace\_period](#output\_complete\_lt\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_complete_lt_autoscaling_group_health_check_type"></a> [complete\_lt\_autoscaling\_group\_health\_check\_type](#output\_complete\_lt\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_complete_lt_autoscaling_group_id"></a> [complete\_lt\_autoscaling\_group\_id](#output\_complete\_lt\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_complete_lt_autoscaling_group_load_balancers"></a> [complete\_lt\_autoscaling\_group\_load\_balancers](#output\_complete\_lt\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_complete_lt_autoscaling_group_max_size"></a> [complete\_lt\_autoscaling\_group\_max\_size](#output\_complete\_lt\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_complete_lt_autoscaling_group_min_size"></a> [complete\_lt\_autoscaling\_group\_min\_size](#output\_complete\_lt\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_complete_lt_autoscaling_group_name"></a> [complete\_lt\_autoscaling\_group\_name](#output\_complete\_lt\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_complete_lt_autoscaling_group_target_group_arns"></a> [complete\_lt\_autoscaling\_group\_target\_group\_arns](#output\_complete\_lt\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_complete_lt_autoscaling_group_vpc_zone_identifier"></a> [complete\_lt\_autoscaling\_group\_vpc\_zone\_identifier](#output\_complete\_lt\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_complete_lt_launch_template_arn"></a> [complete\_lt\_launch\_template\_arn](#output\_complete\_lt\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_complete_lt_launch_template_id"></a> [complete\_lt\_launch\_template\_id](#output\_complete\_lt\_launch\_template\_id) | The ID of the launch template |
| <a name="output_complete_lt_launch_template_latest_version"></a> [complete\_lt\_launch\_template\_latest\_version](#output\_complete\_lt\_launch\_template\_latest\_version) | The latest version of the launch template |
| <a name="output_default_lc_autoscaling_group_arn"></a> [default\_lc\_autoscaling\_group\_arn](#output\_default\_lc\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_default_lc_autoscaling_group_availability_zones"></a> [default\_lc\_autoscaling\_group\_availability\_zones](#output\_default\_lc\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_default_lc_autoscaling_group_default_cooldown"></a> [default\_lc\_autoscaling\_group\_default\_cooldown](#output\_default\_lc\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_default_lc_autoscaling_group_desired_capacity"></a> [default\_lc\_autoscaling\_group\_desired\_capacity](#output\_default\_lc\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_default_lc_autoscaling_group_health_check_grace_period"></a> [default\_lc\_autoscaling\_group\_health\_check\_grace\_period](#output\_default\_lc\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_default_lc_autoscaling_group_health_check_type"></a> [default\_lc\_autoscaling\_group\_health\_check\_type](#output\_default\_lc\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_default_lc_autoscaling_group_id"></a> [default\_lc\_autoscaling\_group\_id](#output\_default\_lc\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_default_lc_autoscaling_group_load_balancers"></a> [default\_lc\_autoscaling\_group\_load\_balancers](#output\_default\_lc\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_default_lc_autoscaling_group_max_size"></a> [default\_lc\_autoscaling\_group\_max\_size](#output\_default\_lc\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_default_lc_autoscaling_group_min_size"></a> [default\_lc\_autoscaling\_group\_min\_size](#output\_default\_lc\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_default_lc_autoscaling_group_name"></a> [default\_lc\_autoscaling\_group\_name](#output\_default\_lc\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_default_lc_autoscaling_group_target_group_arns"></a> [default\_lc\_autoscaling\_group\_target\_group\_arns](#output\_default\_lc\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_default_lc_autoscaling_group_vpc_zone_identifier"></a> [default\_lc\_autoscaling\_group\_vpc\_zone\_identifier](#output\_default\_lc\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_default_lc_launch_configuration_arn"></a> [default\_lc\_launch\_configuration\_arn](#output\_default\_lc\_launch\_configuration\_arn) | The ARN of the launch configuration |
| <a name="output_default_lc_launch_configuration_id"></a> [default\_lc\_launch\_configuration\_id](#output\_default\_lc\_launch\_configuration\_id) | The ID of the launch configuration |
| <a name="output_default_lc_launch_configuration_name"></a> [default\_lc\_launch\_configuration\_name](#output\_default\_lc\_launch\_configuration\_name) | The name of the launch configuration |
| <a name="output_default_lt_autoscaling_group_arn"></a> [default\_lt\_autoscaling\_group\_arn](#output\_default\_lt\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_default_lt_autoscaling_group_availability_zones"></a> [default\_lt\_autoscaling\_group\_availability\_zones](#output\_default\_lt\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_default_lt_autoscaling_group_default_cooldown"></a> [default\_lt\_autoscaling\_group\_default\_cooldown](#output\_default\_lt\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_default_lt_autoscaling_group_desired_capacity"></a> [default\_lt\_autoscaling\_group\_desired\_capacity](#output\_default\_lt\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_default_lt_autoscaling_group_health_check_grace_period"></a> [default\_lt\_autoscaling\_group\_health\_check\_grace\_period](#output\_default\_lt\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_default_lt_autoscaling_group_health_check_type"></a> [default\_lt\_autoscaling\_group\_health\_check\_type](#output\_default\_lt\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_default_lt_autoscaling_group_id"></a> [default\_lt\_autoscaling\_group\_id](#output\_default\_lt\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_default_lt_autoscaling_group_load_balancers"></a> [default\_lt\_autoscaling\_group\_load\_balancers](#output\_default\_lt\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_default_lt_autoscaling_group_max_size"></a> [default\_lt\_autoscaling\_group\_max\_size](#output\_default\_lt\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_default_lt_autoscaling_group_min_size"></a> [default\_lt\_autoscaling\_group\_min\_size](#output\_default\_lt\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_default_lt_autoscaling_group_name"></a> [default\_lt\_autoscaling\_group\_name](#output\_default\_lt\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_default_lt_autoscaling_group_target_group_arns"></a> [default\_lt\_autoscaling\_group\_target\_group\_arns](#output\_default\_lt\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_default_lt_autoscaling_group_vpc_zone_identifier"></a> [default\_lt\_autoscaling\_group\_vpc\_zone\_identifier](#output\_default\_lt\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_default_lt_launch_template_arn"></a> [default\_lt\_launch\_template\_arn](#output\_default\_lt\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_default_lt_launch_template_id"></a> [default\_lt\_launch\_template\_id](#output\_default\_lt\_launch\_template\_id) | The ID of the launch template |
| <a name="output_default_lt_launch_template_latest_version"></a> [default\_lt\_launch\_template\_latest\_version](#output\_default\_lt\_launch\_template\_latest\_version) | The latest version of the launch template |
| <a name="output_external_lc_autoscaling_group_arn"></a> [external\_lc\_autoscaling\_group\_arn](#output\_external\_lc\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_external_lc_autoscaling_group_availability_zones"></a> [external\_lc\_autoscaling\_group\_availability\_zones](#output\_external\_lc\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_external_lc_autoscaling_group_default_cooldown"></a> [external\_lc\_autoscaling\_group\_default\_cooldown](#output\_external\_lc\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_external_lc_autoscaling_group_desired_capacity"></a> [external\_lc\_autoscaling\_group\_desired\_capacity](#output\_external\_lc\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_external_lc_autoscaling_group_health_check_grace_period"></a> [external\_lc\_autoscaling\_group\_health\_check\_grace\_period](#output\_external\_lc\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_external_lc_autoscaling_group_health_check_type"></a> [external\_lc\_autoscaling\_group\_health\_check\_type](#output\_external\_lc\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_external_lc_autoscaling_group_id"></a> [external\_lc\_autoscaling\_group\_id](#output\_external\_lc\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_external_lc_autoscaling_group_load_balancers"></a> [external\_lc\_autoscaling\_group\_load\_balancers](#output\_external\_lc\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_external_lc_autoscaling_group_max_size"></a> [external\_lc\_autoscaling\_group\_max\_size](#output\_external\_lc\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_external_lc_autoscaling_group_min_size"></a> [external\_lc\_autoscaling\_group\_min\_size](#output\_external\_lc\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_external_lc_autoscaling_group_name"></a> [external\_lc\_autoscaling\_group\_name](#output\_external\_lc\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_external_lc_autoscaling_group_target_group_arns"></a> [external\_lc\_autoscaling\_group\_target\_group\_arns](#output\_external\_lc\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_external_lc_autoscaling_group_vpc_zone_identifier"></a> [external\_lc\_autoscaling\_group\_vpc\_zone\_identifier](#output\_external\_lc\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_external_lc_launch_configuration_arn"></a> [external\_lc\_launch\_configuration\_arn](#output\_external\_lc\_launch\_configuration\_arn) | The ARN of the launch configuration |
| <a name="output_external_lc_launch_configuration_id"></a> [external\_lc\_launch\_configuration\_id](#output\_external\_lc\_launch\_configuration\_id) | The ID of the launch configuration |
| <a name="output_external_lc_launch_configuration_name"></a> [external\_lc\_launch\_configuration\_name](#output\_external\_lc\_launch\_configuration\_name) | The name of the launch configuration |
| <a name="output_external_lt_autoscaling_group_arn"></a> [external\_lt\_autoscaling\_group\_arn](#output\_external\_lt\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_external_lt_autoscaling_group_availability_zones"></a> [external\_lt\_autoscaling\_group\_availability\_zones](#output\_external\_lt\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_external_lt_autoscaling_group_default_cooldown"></a> [external\_lt\_autoscaling\_group\_default\_cooldown](#output\_external\_lt\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_external_lt_autoscaling_group_desired_capacity"></a> [external\_lt\_autoscaling\_group\_desired\_capacity](#output\_external\_lt\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_external_lt_autoscaling_group_health_check_grace_period"></a> [external\_lt\_autoscaling\_group\_health\_check\_grace\_period](#output\_external\_lt\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_external_lt_autoscaling_group_health_check_type"></a> [external\_lt\_autoscaling\_group\_health\_check\_type](#output\_external\_lt\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_external_lt_autoscaling_group_id"></a> [external\_lt\_autoscaling\_group\_id](#output\_external\_lt\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_external_lt_autoscaling_group_load_balancers"></a> [external\_lt\_autoscaling\_group\_load\_balancers](#output\_external\_lt\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_external_lt_autoscaling_group_max_size"></a> [external\_lt\_autoscaling\_group\_max\_size](#output\_external\_lt\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_external_lt_autoscaling_group_min_size"></a> [external\_lt\_autoscaling\_group\_min\_size](#output\_external\_lt\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_external_lt_autoscaling_group_name"></a> [external\_lt\_autoscaling\_group\_name](#output\_external\_lt\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_external_lt_autoscaling_group_target_group_arns"></a> [external\_lt\_autoscaling\_group\_target\_group\_arns](#output\_external\_lt\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_external_lt_autoscaling_group_vpc_zone_identifier"></a> [external\_lt\_autoscaling\_group\_vpc\_zone\_identifier](#output\_external\_lt\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_external_lt_launch_template_arn"></a> [external\_lt\_launch\_template\_arn](#output\_external\_lt\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_external_lt_launch_template_id"></a> [external\_lt\_launch\_template\_id](#output\_external\_lt\_launch\_template\_id) | The ID of the launch template |
| <a name="output_external_lt_launch_template_latest_version"></a> [external\_lt\_launch\_template\_latest\_version](#output\_external\_lt\_launch\_template\_latest\_version) | The latest version of the launch template |
| <a name="output_lc_only_launch_configuration_arn"></a> [lc\_only\_launch\_configuration\_arn](#output\_lc\_only\_launch\_configuration\_arn) | The ARN of the launch configuration |
| <a name="output_lc_only_launch_configuration_id"></a> [lc\_only\_launch\_configuration\_id](#output\_lc\_only\_launch\_configuration\_id) | The ID of the launch configuration |
| <a name="output_lc_only_launch_configuration_name"></a> [lc\_only\_launch\_configuration\_name](#output\_lc\_only\_launch\_configuration\_name) | The name of the launch configuration |
| <a name="output_lt_only_launch_template_arn"></a> [lt\_only\_launch\_template\_arn](#output\_lt\_only\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_lt_only_launch_template_id"></a> [lt\_only\_launch\_template\_id](#output\_lt\_only\_launch\_template\_id) | The ID of the launch template |
| <a name="output_lt_only_launch_template_latest_version"></a> [lt\_only\_launch\_template\_latest\_version](#output\_lt\_only\_launch\_template\_latest\_version) | The latest version of the launch template |
| <a name="output_mixed_instance_autoscaling_group_arn"></a> [mixed\_instance\_autoscaling\_group\_arn](#output\_mixed\_instance\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_mixed_instance_autoscaling_group_availability_zones"></a> [mixed\_instance\_autoscaling\_group\_availability\_zones](#output\_mixed\_instance\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_mixed_instance_autoscaling_group_default_cooldown"></a> [mixed\_instance\_autoscaling\_group\_default\_cooldown](#output\_mixed\_instance\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_mixed_instance_autoscaling_group_desired_capacity"></a> [mixed\_instance\_autoscaling\_group\_desired\_capacity](#output\_mixed\_instance\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_mixed_instance_autoscaling_group_health_check_grace_period"></a> [mixed\_instance\_autoscaling\_group\_health\_check\_grace\_period](#output\_mixed\_instance\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_mixed_instance_autoscaling_group_health_check_type"></a> [mixed\_instance\_autoscaling\_group\_health\_check\_type](#output\_mixed\_instance\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_mixed_instance_autoscaling_group_id"></a> [mixed\_instance\_autoscaling\_group\_id](#output\_mixed\_instance\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_mixed_instance_autoscaling_group_load_balancers"></a> [mixed\_instance\_autoscaling\_group\_load\_balancers](#output\_mixed\_instance\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_mixed_instance_autoscaling_group_max_size"></a> [mixed\_instance\_autoscaling\_group\_max\_size](#output\_mixed\_instance\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_mixed_instance_autoscaling_group_min_size"></a> [mixed\_instance\_autoscaling\_group\_min\_size](#output\_mixed\_instance\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_mixed_instance_autoscaling_group_name"></a> [mixed\_instance\_autoscaling\_group\_name](#output\_mixed\_instance\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_mixed_instance_autoscaling_group_target_group_arns"></a> [mixed\_instance\_autoscaling\_group\_target\_group\_arns](#output\_mixed\_instance\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_mixed_instance_autoscaling_group_vpc_zone_identifier"></a> [mixed\_instance\_autoscaling\_group\_vpc\_zone\_identifier](#output\_mixed\_instance\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_mixed_instance_launch_template_arn"></a> [mixed\_instance\_launch\_template\_arn](#output\_mixed\_instance\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_mixed_instance_launch_template_id"></a> [mixed\_instance\_launch\_template\_id](#output\_mixed\_instance\_launch\_template\_id) | The ID of the launch template |
| <a name="output_mixed_instance_launch_template_latest_version"></a> [mixed\_instance\_launch\_template\_latest\_version](#output\_mixed\_instance\_launch\_template\_latest\_version) | The latest version of the launch template |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
