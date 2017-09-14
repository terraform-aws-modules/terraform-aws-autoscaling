# Launch configuration
output "this_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = "${var.existing_launch_configuration != "" ? var.existing_launch_configuration : module.launch_configuration.this_launch_configuration_id}"
}

# Autoscaling group
output "this_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = "${module.autoscaling_group.this_autoscaling_group_id}"
}

output "this_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = "${module.autoscaling_group.this_autoscaling_group_name}"
}

output "this_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = "${module.autoscaling_group.this_autoscaling_group_arn}"
}

output "this_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = "${module.autoscaling_group.this_autoscaling_group_min_size}"
}

output "this_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = "${module.autoscaling_group.this_autoscaling_group_max_size}"
}

output "this_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = "${module.autoscaling_group.this_autoscaling_group_desired_capacity}"
}

output "this_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = "${module.autoscaling_group.this_autoscaling_group_default_cooldown}"
}

output "this_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = "${module.autoscaling_group.this_autoscaling_group_health_check_grace_period}"
}

output "this_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = "${module.autoscaling_group.this_autoscaling_group_health_check_type}"
}

output "this_autoscaling_group_launch_configuration" {
  description = "The launch configuration of the autoscale group"
  value       = "${module.autoscaling_group.this_autoscaling_group_launch_configuration}"
}

output "this_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = "${module.autoscaling_group.this_autoscaling_group_vpc_zone_identifier}"
}

output "this_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = "${module.autoscaling_group.this_autoscaling_group_load_balancers}"
}

output "this_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = "${module.autoscaling_group.this_autoscaling_group_target_group_arns}"
}
