# Auto Scaling Group with initial lifecycle hook

Configuration in this directory creates Launch Template and Auto Scaling Group with initial_lifecycle_hook specified.

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
## Outputs

| Name | Description |
|------|-------------|
| this\_autoscaling\_group\_id | The autoscaling group id |
| this\_launch\_template\_id | The ID of the launch template |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
