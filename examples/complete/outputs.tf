################################################################################
# Launch template only
################################################################################

output "launch_template_only_launch_template_id" {
  description = "The ID of the launch template"
  value       = module.launch_template_only.launch_template_id
}

output "launch_template_only_launch_template_arn" {
  description = "The ARN of the launch template"
  value       = module.launch_template_only.launch_template_arn
}

output "launch_template_only_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.launch_template_only.launch_template_latest_version
}

################################################################################
# Default
################################################################################

output "default_launch_template_id" {
  description = "The ID of the launch template"
  value       = module.default.launch_template_id
}

output "default_launch_template_arn" {
  description = "The ARN of the launch template"
  value       = module.default.launch_template_arn
}

output "default_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.default.launch_template_latest_version
}

output "default_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.default.autoscaling_group_id
}

output "default_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.default.autoscaling_group_name
}

output "default_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.default.autoscaling_group_arn
}

output "default_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.default.autoscaling_group_min_size
}

output "default_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.default.autoscaling_group_max_size
}

output "default_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.default.autoscaling_group_desired_capacity
}

output "default_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.default.autoscaling_group_default_cooldown
}

output "default_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.default.autoscaling_group_health_check_grace_period
}

output "default_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.default.autoscaling_group_health_check_type
}

output "default_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.default.autoscaling_group_availability_zones
}

output "default_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.default.autoscaling_group_vpc_zone_identifier
}

output "default_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.default.autoscaling_group_load_balancers
}

output "default_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.default.autoscaling_group_target_group_arns
}

################################################################################
# External
################################################################################

output "external_launch_template_id" {
  description = "The ID of the launch template"
  value       = module.external.launch_template_id
}

output "external_launch_template_arn" {
  description = "The ARN of the launch template"
  value       = module.external.launch_template_arn
}

output "external_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.external.launch_template_latest_version
}

output "external_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.external.autoscaling_group_id
}

output "external_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.external.autoscaling_group_name
}

output "external_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.external.autoscaling_group_arn
}

output "external_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.external.autoscaling_group_min_size
}

output "external_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.external.autoscaling_group_max_size
}

output "external_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.external.autoscaling_group_desired_capacity
}

output "external_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.external.autoscaling_group_default_cooldown
}

output "external_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.external.autoscaling_group_health_check_grace_period
}

output "external_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.external.autoscaling_group_health_check_type
}

output "external_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.external.autoscaling_group_availability_zones
}

output "external_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.external.autoscaling_group_vpc_zone_identifier
}

output "external_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.external.autoscaling_group_load_balancers
}

output "external_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.external.autoscaling_group_target_group_arns
}

################################################################################
# Complete
################################################################################

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

output "complete_autoscaling_schedule_arns" {
  description = "ARNs of autoscaling group schedules"
  value       = module.complete.autoscaling_schedule_arns
}

output "complete_autoscaling_policy_arns" {
  description = "ARNs of autoscaling policies"
  value       = module.complete.autoscaling_policy_arns
}

################################################################################
# Mixed instance policy
################################################################################

output "mixed_instance_launch_template_id" {
  description = "The ID of the launch template"
  value       = module.mixed_instance.launch_template_id
}

output "mixed_instance_launch_template_arn" {
  description = "The ARN of the launch template"
  value       = module.mixed_instance.launch_template_arn
}

output "mixed_instance_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.mixed_instance.launch_template_latest_version
}

output "mixed_instance_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.mixed_instance.autoscaling_group_id
}

output "mixed_instance_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.mixed_instance.autoscaling_group_name
}

output "mixed_instance_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.mixed_instance.autoscaling_group_arn
}

output "mixed_instance_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.mixed_instance.autoscaling_group_min_size
}

output "mixed_instance_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.mixed_instance.autoscaling_group_max_size
}

output "mixed_instance_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.mixed_instance.autoscaling_group_desired_capacity
}

output "mixed_instance_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.mixed_instance.autoscaling_group_default_cooldown
}

output "mixed_instance_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.mixed_instance.autoscaling_group_health_check_grace_period
}

output "mixed_instance_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.mixed_instance.autoscaling_group_health_check_type
}

output "mixed_instance_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.mixed_instance.autoscaling_group_availability_zones
}

output "mixed_instance_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.mixed_instance.autoscaling_group_vpc_zone_identifier
}

output "mixed_instance_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.mixed_instance.autoscaling_group_load_balancers
}

output "mixed_instance_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.mixed_instance.autoscaling_group_target_group_arns
}
