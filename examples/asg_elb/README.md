# Auto Scaling Group with ELB example

Configuration in this directory creates Launch Configuration, Auto Scaling Group, Elastic Load Balancer and places Auto Scaling EC2 instances under ELB.

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.41 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.41 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_elb"></a> [elb](#module\_elb) | terraform-aws-modules/elb/aws |  |
| <a name="module_example_asg"></a> [example\_asg](#module\_example\_asg) | ../../ |  |

## Resources

| Name | Type |
|------|------|
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet_ids.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_autoscaling_group_id"></a> [this\_autoscaling\_group\_id](#output\_this\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_this_elb_dns_name"></a> [this\_elb\_dns\_name](#output\_this\_elb\_dns\_name) | DNS Name of the ELB |
| <a name="output_this_launch_configuration_id"></a> [this\_launch\_configuration\_id](#output\_this\_launch\_configuration\_id) | The ID of the launch configuration |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
