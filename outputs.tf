locals {
  this_launch_configuration_id   = var.launch_configuration == "" && var.create_lc ? concat(aws_launch_configuration.this.*.id, [""])[0] : var.launch_configuration
  this_launch_configuration_name = var.launch_configuration == "" && var.create_lc ? concat(aws_launch_configuration.this.*.name, [""])[0] : ""

  this_autoscaling_group_id                        = concat(aws_autoscaling_group.this.*.id, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.id, [""])[0]
  this_autoscaling_group_name                      = concat(aws_autoscaling_group.this.*.name, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.name, [""])[0]
  this_autoscaling_group_arn                       = concat(aws_autoscaling_group.this.*.arn, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.arn, [""])[0]
  this_autoscaling_group_min_size                  = concat(aws_autoscaling_group.this.*.min_size, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.min_size, [""])[0]
  this_autoscaling_group_max_size                  = concat(aws_autoscaling_group.this.*.max_size, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.max_size, [""])[0]
  this_autoscaling_group_desired_capacity          = concat(aws_autoscaling_group.this.*.desired_capacity, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.desired_capacity, [""])[0]
  this_autoscaling_group_default_cooldown          = concat(aws_autoscaling_group.this.*.default_cooldown, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.default_cooldown, [""])[0]
  this_autoscaling_group_health_check_grace_period = concat(aws_autoscaling_group.this.*.health_check_grace_period, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.health_check_grace_period, [""])[0]
  this_autoscaling_group_health_check_type         = concat(aws_autoscaling_group.this.*.health_check_type, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.health_check_type, [""])[0]
  this_autoscaling_group_availability_zones        = concat(aws_autoscaling_group.this.*.availability_zones, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.availability_zones, [""])[0]
  this_autoscaling_group_vpc_zone_identifier       = concat(aws_autoscaling_group.this.*.vpc_zone_identifier, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.vpc_zone_identifier, [""])[0]
  this_autoscaling_group_load_balancers            = concat(aws_autoscaling_group.this.*.load_balancers, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.load_balancers, [""])[0]
  this_autoscaling_group_target_group_arns         = concat(aws_autoscaling_group.this.*.target_group_arns, aws_autoscaling_group.this_with_initial_lifecycle_hook.*.target_group_arns, [""])[0]
}

output "this_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = local.this_launch_configuration_id
}

output "this_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = local.this_launch_configuration_name
}

output "this_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = local.this_autoscaling_group_id
}

output "this_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = local.this_autoscaling_group_name
}

output "this_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = local.this_autoscaling_group_arn
}

output "this_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = local.this_autoscaling_group_min_size
}

output "this_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = local.this_autoscaling_group_max_size
}

output "this_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = local.this_autoscaling_group_desired_capacity
}

output "this_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = local.this_autoscaling_group_default_cooldown
}

output "this_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = local.this_autoscaling_group_health_check_grace_period
}

output "this_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = local.this_autoscaling_group_health_check_type
}

output "this_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = local.this_autoscaling_group_availability_zones
}

output "this_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = local.this_autoscaling_group_vpc_zone_identifier
}

output "this_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = local.this_autoscaling_group_load_balancers
}

output "this_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = local.this_autoscaling_group_target_group_arns
}
