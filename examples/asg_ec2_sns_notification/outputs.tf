# Launch configuration
output "this_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = "${module.example_asg.this_launch_configuration_id}"
}

# Autoscaling group
output "this_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = "${module.example_asg.this_autoscaling_group_id}"
}

# ELB DNS name
output "this_elb_dns_name" {
  description = "DNS Name of the ELB"
  value       = "${module.elb.this_elb_dns_name}"
}

# Notification Topic - Pure SNS
output "this_pure_sns_topic" {
  description = "ARN of the SNS topic you can subscribe to receive notifications"
  value       = "${module.sns_topic.this_sns_topic_arn}"
}

# Notification Topic - Slack
output "this_slack_sns_topic" {
  description = "ARN of the SNS topic you can subscribe to receive notifications"
  value       = "${module.notify_slack.this_slack_topic_arn}"
}
