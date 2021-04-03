# Auto Scaling Group with Mixed Instances Policy

Configuration in this directory creates an autoscaling group utilizing a mixed instance policy based on the launch template created.

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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.30 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.30 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete"></a> [complete](#module\_complete) | ../../ |  |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 2 |

## Resources

| Name | Type |
|------|------|
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
| <a name="output_complete_launch_template_arn"></a> [complete\_launch\_template\_arn](#output\_complete\_launch\_template\_arn) | The ARN of the launch template |
| <a name="output_complete_launch_template_id"></a> [complete\_launch\_template\_id](#output\_complete\_launch\_template\_id) | The ID of the launch template |
| <a name="output_complete_launch_template_latest_version"></a> [complete\_launch\_template\_latest\_version](#output\_complete\_launch\_template\_latest\_version) | The latest version of the launch template |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
