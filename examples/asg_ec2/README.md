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
| <a name="module_example"></a> [example](#module\_example) | ../../ |  |

## Resources

| Name | Type |
|------|------|
| [aws_iam_service_linked_role.autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet_ids.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_autoscaling_group_availability_zones"></a> [this\_autoscaling\_group\_availability\_zones](#output\_this\_autoscaling\_group\_availability\_zones) | The availability zones of the autoscale group |
| <a name="output_this_autoscaling_group_id"></a> [this\_autoscaling\_group\_id](#output\_this\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_this_autoscaling_group_load_balancers"></a> [this\_autoscaling\_group\_load\_balancers](#output\_this\_autoscaling\_group\_load\_balancers) | The load balancer names associated with the autoscaling group |
| <a name="output_this_autoscaling_group_target_group_arns"></a> [this\_autoscaling\_group\_target\_group\_arns](#output\_this\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group |
| <a name="output_this_autoscaling_group_vpc_zone_identifier"></a> [this\_autoscaling\_group\_vpc\_zone\_identifier](#output\_this\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier |
| <a name="output_this_launch_configuration_id"></a> [this\_launch\_configuration\_id](#output\_this\_launch\_configuration\_id) | The ID of the launch configuration |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
