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

## Outputs

| Name | Description |
|------|-------------|
| this_autoscaling_group_id | Autoscaling group |
| this_elb_dns_name | ELB DNS name |
| this_launch_configuration_id | Launch configuration |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
