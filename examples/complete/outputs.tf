################################################################################
# Configuration only
################################################################################

# Launch template
output "lt_only_launch_template_id" {
  description = "The ID of the launch template"
  value       = module.lt_only.launch_template_id
}

output "lt_only_launch_template_arn" {
  description = "The ARN of the launch template"
  value       = module.lt_only.launch_template_arn
}

output "lt_only_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.lt_only.launch_template_latest_version
}

# Launch configuration
output "lc_only_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = module.lc_only.launch_configuration_id
}

output "lc_only_launch_configuration_arn" {
  description = "The ARN of the launch configuration"
  value       = module.lc_only.launch_configuration_arn
}

output "lc_only_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = module.lc_only.launch_configuration_name
}

################################################################################
# Default
################################################################################

# Launch template
output "default_lt_launch_template_id" {
  description = "The ID of the launch template"
  value       = module.default_lt.launch_template_id
}

output "default_lt_launch_template_arn" {
  description = "The ARN of the launch template"
  value       = module.default_lt.launch_template_arn
}

output "default_lt_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.default_lt.launch_template_latest_version
}

output "default_lt_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.default_lt.autoscaling_group_id
}

output "default_lt_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.default_lt.autoscaling_group_name
}

output "default_lt_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.default_lt.autoscaling_group_arn
}

output "default_lt_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.default_lt.autoscaling_group_min_size
}

output "default_lt_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.default_lt.autoscaling_group_max_size
}

output "default_lt_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.default_lt.autoscaling_group_desired_capacity
}

output "default_lt_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.default_lt.autoscaling_group_default_cooldown
}

output "default_lt_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.default_lt.autoscaling_group_health_check_grace_period
}

output "default_lt_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.default_lt.autoscaling_group_health_check_type
}

output "default_lt_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.default_lt.autoscaling_group_availability_zones
}

output "default_lt_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.default_lt.autoscaling_group_vpc_zone_identifier
}

output "default_lt_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.default_lt.autoscaling_group_load_balancers
}

output "default_lt_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.default_lt.autoscaling_group_target_group_arns
}

# Launch configuration
output "default_lc_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = module.default_lc.launch_configuration_id
}

output "default_lc_launch_configuration_arn" {
  description = "The ARN of the launch configuration"
  value       = module.default_lc.launch_configuration_arn
}

output "default_lc_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = module.default_lc.launch_configuration_name
}

output "default_lc_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.default_lc.autoscaling_group_id
}

output "default_lc_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.default_lc.autoscaling_group_name
}

output "default_lc_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.default_lc.autoscaling_group_arn
}

output "default_lc_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.default_lc.autoscaling_group_min_size
}

output "default_lc_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.default_lc.autoscaling_group_max_size
}

output "default_lc_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.default_lc.autoscaling_group_desired_capacity
}

output "default_lc_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.default_lc.autoscaling_group_default_cooldown
}

output "default_lc_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.default_lc.autoscaling_group_health_check_grace_period
}

output "default_lc_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.default_lc.autoscaling_group_health_check_type
}

output "default_lc_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.default_lc.autoscaling_group_availability_zones
}

output "default_lc_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.default_lc.autoscaling_group_vpc_zone_identifier
}

output "default_lc_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.default_lc.autoscaling_group_load_balancers
}

output "default_lc_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.default_lc.autoscaling_group_target_group_arns
}

################################################################################
# External
################################################################################

# Launch template
output "external_lt_launch_template_id" {
  description = "The ID of the launch template"
  value       = module.external_lt.launch_template_id
}

output "external_lt_launch_template_arn" {
  description = "The ARN of the launch template"
  value       = module.external_lt.launch_template_arn
}

output "external_lt_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.external_lt.launch_template_latest_version
}

output "external_lt_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.external_lt.autoscaling_group_id
}

output "external_lt_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.external_lt.autoscaling_group_name
}

output "external_lt_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.external_lt.autoscaling_group_arn
}

output "external_lt_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.external_lt.autoscaling_group_min_size
}

output "external_lt_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.external_lt.autoscaling_group_max_size
}

output "external_lt_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.external_lt.autoscaling_group_desired_capacity
}

output "external_lt_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.external_lt.autoscaling_group_default_cooldown
}

output "external_lt_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.external_lt.autoscaling_group_health_check_grace_period
}

output "external_lt_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.external_lt.autoscaling_group_health_check_type
}

output "external_lt_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.external_lt.autoscaling_group_availability_zones
}

output "external_lt_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.external_lt.autoscaling_group_vpc_zone_identifier
}

output "external_lt_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.external_lt.autoscaling_group_load_balancers
}

output "external_lt_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.external_lt.autoscaling_group_target_group_arns
}

# Launch configuration
output "external_lc_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = module.external_lc.launch_configuration_id
}

output "external_lc_launch_configuration_arn" {
  description = "The ARN of the launch configuration"
  value       = module.external_lc.launch_configuration_arn
}

output "external_lc_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = module.external_lc.launch_configuration_name
}

output "external_lc_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.external_lc.autoscaling_group_id
}

output "external_lc_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.external_lc.autoscaling_group_name
}

output "external_lc_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.external_lc.autoscaling_group_arn
}

output "external_lc_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.external_lc.autoscaling_group_min_size
}

output "external_lc_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.external_lc.autoscaling_group_max_size
}

output "external_lc_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.external_lc.autoscaling_group_desired_capacity
}

output "external_lc_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.external_lc.autoscaling_group_default_cooldown
}

output "external_lc_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.external_lc.autoscaling_group_health_check_grace_period
}

output "external_lc_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.external_lc.autoscaling_group_health_check_type
}

output "external_lc_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.external_lc.autoscaling_group_availability_zones
}

output "external_lc_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.external_lc.autoscaling_group_vpc_zone_identifier
}

output "external_lc_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.external_lc.autoscaling_group_load_balancers
}

output "external_lc_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.external_lc.autoscaling_group_target_group_arns
}

################################################################################
# Complete
################################################################################

# Launch template
output "complete_lt_launch_template_id" {
  description = "The ID of the launch template"
  value       = module.complete_lt.launch_template_id
}

output "complete_lt_launch_template_arn" {
  description = "The ARN of the launch template"
  value       = module.complete_lt.launch_template_arn
}

output "complete_lt_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.complete_lt.launch_template_latest_version
}

output "complete_lt_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.complete_lt.autoscaling_group_id
}

output "complete_lt_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.complete_lt.autoscaling_group_name
}

output "complete_lt_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.complete_lt.autoscaling_group_arn
}

output "complete_lt_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.complete_lt.autoscaling_group_min_size
}

output "complete_lt_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.complete_lt.autoscaling_group_max_size
}

output "complete_lt_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.complete_lt.autoscaling_group_desired_capacity
}

output "complete_lt_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.complete_lt.autoscaling_group_default_cooldown
}

output "complete_lt_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.complete_lt.autoscaling_group_health_check_grace_period
}

output "complete_lt_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.complete_lt.autoscaling_group_health_check_type
}

output "complete_lt_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.complete_lt.autoscaling_group_availability_zones
}

output "complete_lt_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.complete_lt.autoscaling_group_vpc_zone_identifier
}

output "complete_lt_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.complete_lt.autoscaling_group_load_balancers
}

output "complete_lt_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.complete_lt.autoscaling_group_target_group_arns
}

output "complete_lt_autoscaling_schedule_arns" {
  description = "ARNs of autoscaling group schedules"
  value       = module.complete_lt.autoscaling_schedule_arns
}

# Launch configuration
output "complete_lc_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = module.complete_lc.launch_configuration_id
}

output "complete_lc_launch_configuration_arn" {
  description = "The ARN of the launch configuration"
  value       = module.complete_lc.launch_configuration_arn
}

output "complete_lc_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = module.complete_lc.launch_configuration_name
}

output "complete_lc_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.complete_lc.autoscaling_group_id
}

output "complete_lc_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.complete_lc.autoscaling_group_name
}

output "complete_lc_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.complete_lc.autoscaling_group_arn
}

output "complete_lc_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.complete_lc.autoscaling_group_min_size
}

output "complete_lc_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.complete_lc.autoscaling_group_max_size
}

output "complete_lc_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.complete_lc.autoscaling_group_desired_capacity
}

output "complete_lc_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.complete_lc.autoscaling_group_default_cooldown
}

output "complete_lc_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.complete_lc.autoscaling_group_health_check_grace_period
}

output "complete_lc_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.complete_lc.autoscaling_group_health_check_type
}

output "complete_lc_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.complete_lc.autoscaling_group_availability_zones
}

output "complete_lc_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.complete_lc.autoscaling_group_vpc_zone_identifier
}

output "complete_lc_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.complete_lc.autoscaling_group_load_balancers
}

output "complete_lc_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.complete_lc.autoscaling_group_target_group_arns
}

output "complete_lc_autoscaling_policy_arns" {
  description = "ARNs of autoscaling policies"
  value       = module.complete_lt.autoscaling_policy_arns
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
