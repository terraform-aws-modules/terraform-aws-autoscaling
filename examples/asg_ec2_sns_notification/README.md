# Auto Scaling Group with SNS Notifications Example

Configuration in this directory creates Launch Configuration, Auto Scaling Group, Elastic Load Balancer, places Auto Scaling EC2 instances under ELB as well as SNS Topics which is used to notify on scaling events, another SNS topics with Slack integration is created. The Auto Scaling Group is connected to these topics via Scaling Notification mechanism.

Data sources are used to discover existing VPC resources (VPC, subnet and security group) as well as AMI details.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## `notification_scalings` - Ordering of applying and the use of `count`

Due to [the complication of using `count`](https://github.com/hashicorp/terraform/issues/12570) and [the upcoming plan to fix it](https://github.com/hashicorp/terraform/issues/4149), the parameter `scaling_notification` assumes that the resources that you are referring to form it (ie. the SNS topics) must have already been created.

That means within this example (as when as when you use the `scaling_notification` variable, you will have to make sure that the SNS Topics is created before you apply this module (I think that's reasonable). The `Usage` section below shows how you can use the flag `-target` to ensure such behaviour.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Outputs

| Name | Description |
|------|-------------|
| this_autoscaling_group_id | The autoscaling group id |
| this_elb_dns_name | DNS Name of the ELB |
| this_launch_configuration_id | The ID of the launch configuration |
| this_pure_sns_topic | ARN of the SNS topic you can subscribe to receive notifications |
| this_slack_sns_topic | ARN of the SNS topic you can subscribe to receive notifications |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
