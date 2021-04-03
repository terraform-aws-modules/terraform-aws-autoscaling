################################################################################
# Launch template
################################################################################

# Launch template
output "complete_launch_template_id" {
  description = "The ID of the launch template"
  value       = module.complete.launch_template_id
}

output "complete_launch_template_arn" {
  description = "The ARN of the launch template"
  value       = module.complete.launch_template_arn
}

output "complete_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.complete.launch_template_latest_version
}

# Autoscaling group
output "complete_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.complete.autoscaling_group_id
}

output "complete_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.complete.autoscaling_group_name
}

output "complete_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.complete.autoscaling_group_arn
}

output "complete_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.complete.autoscaling_group_min_size
}

output "complete_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.complete.autoscaling_group_max_size
}

output "complete_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.complete.autoscaling_group_desired_capacity
}

output "complete_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.complete.autoscaling_group_default_cooldown
}

output "complete_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.complete.autoscaling_group_health_check_grace_period
}

output "complete_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.complete.autoscaling_group_health_check_type
}

output "complete_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.complete.autoscaling_group_availability_zones
}

output "complete_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.complete.autoscaling_group_vpc_zone_identifier
}

output "complete_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.complete.autoscaling_group_load_balancers
}

output "complete_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.complete.autoscaling_group_target_group_arns
}
