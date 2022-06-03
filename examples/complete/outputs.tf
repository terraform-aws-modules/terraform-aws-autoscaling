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

output "launch_template_only_launch_template_name" {
  description = "The name of the launch template"
  value       = module.launch_template_only.launch_template_name
}

output "launch_template_only_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.launch_template_only.launch_template_latest_version
}

output "launch_template_only_launch_template_default_version" {
  description = "The default version of the launch template"
  value       = module.launch_template_only.launch_template_default_version
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

output "default_launch_template_name" {
  description = "The name of the launch template"
  value       = module.default.launch_template_name
}

output "default_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.default.launch_template_latest_version
}

output "default_launch_template_default_version" {
  description = "The default version of the launch template"
  value       = module.default.launch_template_default_version
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

output "default_autoscaling_group_enabled_metrics" {
  description = "List of metrics enabled for collection"
  value       = module.default.autoscaling_group_enabled_metrics
}

output "default_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.default.iam_role_name
}

output "default_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.default.iam_role_arn
}

output "default_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.default.iam_role_unique_id
}

output "default_iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.default.iam_instance_profile_arn
}

output "default_iam_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.default.iam_instance_profile_id
}

output "default_iam_instance_profile_unique" {
  description = "Stable and unique string identifying the IAM instance profile"
  value       = module.default.iam_instance_profile_unique
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

output "external_launch_template_name" {
  description = "The name of the launch template"
  value       = module.external.launch_template_name
}

output "external_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.external.launch_template_latest_version
}

output "external_launch_template_default_version" {
  description = "The default version of the launch template"
  value       = module.external.launch_template_default_version
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

output "external_autoscaling_group_enabled_metrics" {
  description = "List of metrics enabled for collection"
  value       = module.external.autoscaling_group_enabled_metrics
}

output "external_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.external.iam_role_name
}

output "external_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.external.iam_role_arn
}

output "external_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.external.iam_role_unique_id
}

output "external_iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.external.iam_instance_profile_arn
}

output "external_iam_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.external.iam_instance_profile_id
}

output "external_iam_instance_profile_unique" {
  description = "Stable and unique string identifying the IAM instance profile"
  value       = module.external.iam_instance_profile_unique
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

output "complete_launch_template_name" {
  description = "The name of the launch template"
  value       = module.complete.launch_template_name
}

output "complete_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.complete.launch_template_latest_version
}

output "complete_launch_template_default_version" {
  description = "The default version of the launch template"
  value       = module.complete.launch_template_default_version
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

output "complete_autoscaling_group_enabled_metrics" {
  description = "List of metrics enabled for collection"
  value       = module.complete.autoscaling_group_enabled_metrics
}

output "complete_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.complete.iam_role_name
}

output "complete_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.complete.iam_role_arn
}

output "complete_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.complete.iam_role_unique_id
}

output "complete_iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.complete.iam_instance_profile_arn
}

output "complete_iam_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.complete.iam_instance_profile_id
}

output "complete_iam_instance_profile_unique" {
  description = "Stable and unique string identifying the IAM instance profile"
  value       = module.complete.iam_instance_profile_unique
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

output "mixed_instance_launch_template_name" {
  description = "The name of the launch template"
  value       = module.mixed_instance.launch_template_name
}

output "mixed_instance_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.mixed_instance.launch_template_latest_version
}

output "mixed_instance_launch_template_default_version" {
  description = "The default version of the launch template"
  value       = module.mixed_instance.launch_template_default_version
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

output "mixed_instance_autoscaling_group_enabled_metrics" {
  description = "List of metrics enabled for collection"
  value       = module.mixed_instance.autoscaling_group_enabled_metrics
}

output "mixed_instance_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.mixed_instance.iam_role_name
}

output "mixed_instance_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.mixed_instance.iam_role_arn
}

output "mixed_instance_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.mixed_instance.iam_role_unique_id
}

output "mixed_instance_iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.mixed_instance.iam_instance_profile_arn
}

output "mixed_instance_iam_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.mixed_instance.iam_instance_profile_id
}

output "mixed_instance_iam_instance_profile_unique" {
  description = "Stable and unique string identifying the IAM instance profile"
  value       = module.mixed_instance.iam_instance_profile_unique
}
