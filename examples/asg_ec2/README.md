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
| this\_autoscaling\_group\_availability\_zones | The availability zones of the autoscale group |
| this\_autoscaling\_group\_id | The autoscaling group id |
| this\_autoscaling\_group\_load\_balancers | The load balancer names associated with the autoscaling group |
| this\_autoscaling\_group\_target\_group\_arns | List of Target Group ARNs that apply to this AutoScaling Group |
| this\_autoscaling\_group\_vpc\_zone\_identifier | The VPC zone identifier |
| this\_launch\_configuration\_id | The ID of the launch configuration |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
