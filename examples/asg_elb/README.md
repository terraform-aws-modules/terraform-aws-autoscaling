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
| terraform | >= 0.12.6 |
| aws | >= 2.41 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.41 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| elb | terraform-aws-modules/elb/aws |  |
| example_asg | ../../ |  |

## Resources

| Name |
|------|
| [aws_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) |
| [aws_subnet_ids](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) |
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| this\_autoscaling\_group\_id | The autoscaling group id |
| this\_elb\_dns\_name | DNS Name of the ELB |
| this\_launch\_configuration\_id | The ID of the launch configuration |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
