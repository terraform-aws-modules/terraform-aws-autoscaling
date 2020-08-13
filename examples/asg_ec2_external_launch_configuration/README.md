# Auto Scaling Group with external launch configuration example

Configuration in this directory creates Launch Configuration outside of the module and pass it to this module to create an Auto Scaling Group.

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

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| this\_autoscaling\_group\_id | The autoscaling group id |
| this\_launch\_configuration\_id | The ID of the launch configuration |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
