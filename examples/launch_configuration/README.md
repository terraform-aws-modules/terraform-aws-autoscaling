# Auto Scaling Group without ELB example

Configuration in this directory creates Launch Configuration and Auto Scaling Group.

Data sources are used to discover existing VPC resources (VPC, subnet and security group) as well as AMI details.

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.26 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.41 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.41 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete"></a> [complete](#module\_complete) | ../../ |  |
| <a name="module_default"></a> [default](#module\_default) | ../../ |  |
| <a name="module_disabled"></a> [disabled](#module\_disabled) | ../../ |  |
| <a name="module_external"></a> [external](#module\_external) | ../../ |  |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 3 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 2 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_service_linked_role.autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_launch_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
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
| <a name="output_complete_autoscaling_group_health_check_grace_period"></a> [complete\_autoscaling\_group\_health\_check\_grace\_period](#output\_complete\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_complete_autoscaling_group_health_check_type"></a> [complete\_autoscaling\_group\_health\_check\_type](#output\_complete\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_complete_autoscaling_group_id"></a> [complete\_autoscaling\_group\_id](#output\_complete\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_complete_autoscaling_group_load_balancers"></a> [complete\_autoscaling\_group\_load\_balancers](#output\_complete\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_complete_autoscaling_group_max_size"></a> [complete\_autoscaling\_group\_max\_size](#output\_complete\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_complete_autoscaling_group_min_size"></a> [complete\_autoscaling\_group\_min\_size](#output\_complete\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_complete_autoscaling_group_name"></a> [complete\_autoscaling\_group\_name](#output\_complete\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_complete_autoscaling_group_target_group_arns"></a> [complete\_autoscaling\_group\_target\_group\_arns](#output\_complete\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_complete_autoscaling_group_vpc_zone_identifier"></a> [complete\_autoscaling\_group\_vpc\_zone\_identifier](#output\_complete\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_complete_launch_configuration_arn"></a> [complete\_launch\_configuration\_arn](#output\_complete\_launch\_configuration\_arn) | The ARN of the launch configuration |
| <a name="output_complete_launch_configuration_id"></a> [complete\_launch\_configuration\_id](#output\_complete\_launch\_configuration\_id) | The ID of the launch configuration |
| <a name="output_complete_launch_configuration_name"></a> [complete\_launch\_configuration\_name](#output\_complete\_launch\_configuration\_name) | The name of the launch configuration |
| <a name="output_default_autoscaling_group_arn"></a> [default\_autoscaling\_group\_arn](#output\_default\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_default_autoscaling_group_availability_zones"></a> [default\_autoscaling\_group\_availability\_zones](#output\_default\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_default_autoscaling_group_default_cooldown"></a> [default\_autoscaling\_group\_default\_cooldown](#output\_default\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_default_autoscaling_group_desired_capacity"></a> [default\_autoscaling\_group\_desired\_capacity](#output\_default\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_default_autoscaling_group_health_check_grace_period"></a> [default\_autoscaling\_group\_health\_check\_grace\_period](#output\_default\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_default_autoscaling_group_health_check_type"></a> [default\_autoscaling\_group\_health\_check\_type](#output\_default\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_default_autoscaling_group_id"></a> [default\_autoscaling\_group\_id](#output\_default\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_default_autoscaling_group_load_balancers"></a> [default\_autoscaling\_group\_load\_balancers](#output\_default\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_default_autoscaling_group_max_size"></a> [default\_autoscaling\_group\_max\_size](#output\_default\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_default_autoscaling_group_min_size"></a> [default\_autoscaling\_group\_min\_size](#output\_default\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_default_autoscaling_group_name"></a> [default\_autoscaling\_group\_name](#output\_default\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_default_autoscaling_group_target_group_arns"></a> [default\_autoscaling\_group\_target\_group\_arns](#output\_default\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_default_autoscaling_group_vpc_zone_identifier"></a> [default\_autoscaling\_group\_vpc\_zone\_identifier](#output\_default\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_default_launch_configuration_arn"></a> [default\_launch\_configuration\_arn](#output\_default\_launch\_configuration\_arn) | The ARN of the launch configuration |
| <a name="output_default_launch_configuration_id"></a> [default\_launch\_configuration\_id](#output\_default\_launch\_configuration\_id) | The ID of the launch configuration |
| <a name="output_default_launch_configuration_name"></a> [default\_launch\_configuration\_name](#output\_default\_launch\_configuration\_name) | The name of the launch configuration |
| <a name="output_external_autoscaling_group_arn"></a> [external\_autoscaling\_group\_arn](#output\_external\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_external_autoscaling_group_availability_zones"></a> [external\_autoscaling\_group\_availability\_zones](#output\_external\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_external_autoscaling_group_default_cooldown"></a> [external\_autoscaling\_group\_default\_cooldown](#output\_external\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_external_autoscaling_group_desired_capacity"></a> [external\_autoscaling\_group\_desired\_capacity](#output\_external\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_external_autoscaling_group_health_check_grace_period"></a> [external\_autoscaling\_group\_health\_check\_grace\_period](#output\_external\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_external_autoscaling_group_health_check_type"></a> [external\_autoscaling\_group\_health\_check\_type](#output\_external\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done |
| <a name="output_external_autoscaling_group_id"></a> [external\_autoscaling\_group\_id](#output\_external\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_external_autoscaling_group_load_balancers"></a> [external\_autoscaling\_group\_load\_balancers](#output\_external\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_external_autoscaling_group_max_size"></a> [external\_autoscaling\_group\_max\_size](#output\_external\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_external_autoscaling_group_min_size"></a> [external\_autoscaling\_group\_min\_size](#output\_external\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_external_autoscaling_group_name"></a> [external\_autoscaling\_group\_name](#output\_external\_autoscaling\_group\_name) | The autoscaling group name |
| <a name="output_external_autoscaling_group_target_group_arns"></a> [external\_autoscaling\_group\_target\_group\_arns](#output\_external\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_external_autoscaling_group_vpc_zone_identifier"></a> [external\_autoscaling\_group\_vpc\_zone\_identifier](#output\_external\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_external_launch_configuration_arn"></a> [external\_launch\_configuration\_arn](#output\_external\_launch\_configuration\_arn) | The ARN of the launch configuration |
| <a name="output_external_launch_configuration_id"></a> [external\_launch\_configuration\_id](#output\_external\_launch\_configuration\_id) | The ID of the launch configuration |
| <a name="output_external_launch_configuration_name"></a> [external\_launch\_configuration\_name](#output\_external\_launch\_configuration\_name) | The name of the launch configuration |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
