# Auto Scaling Group with a custom service linked role

Configuration in this directory creates Launch Configuration and Auto Scaling Group 
with a customized service linked role. This is normally leveraged so that the ASG
can use encrypted AMIs.

Data sources are used to discover existing VPC resources (VPC, subnet and security group) as well as AMI details.

NOTE:

 - Creating the service-linked role within the same terraform run might fail with the 
   following error, most likely due to the IAM syncing in the background. Re-running terraform apply
   again will work.

Error: Error applying plan:

1 error occurred:
	* module.example.aws_autoscaling_group.this: 1 error occurred:
	* aws_autoscaling_group.this: Error creating AutoScaling Group: ValidationError: ARN specified for Service-Linked Role does not exist.
	status code: 400, request id: f127baea-a76c-11e9-8ad4-dd6bbb197602

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
| this\_launch\_configuration\_id | The ID of the launch configuration |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
