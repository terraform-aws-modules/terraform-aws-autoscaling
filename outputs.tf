################################################################################
# Launch configuration
################################################################################

output "launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = element(concat(aws_launch_configuration.this.*.id, [""]), 0)
}

output "launch_configuration_arn" {
  description = "The ARN of the launch configuration"
  value       = element(concat(aws_launch_configuration.this.*.arn, [""]), 0)
}

output "launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = element(concat(aws_launch_configuration.this.*.name, [""]), 0)
}

################################################################################
# Launch template
################################################################################

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = element(concat(aws_launch_template.this.*.id, [""]), 0)
}

output "launch_template_arn" {
  description = "The ARN of the launch template"
  value       = element(concat(aws_launch_template.this.*.arn, [""]), 0)
}

output "launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = element(concat(aws_launch_template.this.*.latest_version, [""]), 0)
}

################################################################################
# Autoscaling group
################################################################################

output "autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = element(concat(aws_autoscaling_group.this.*.id, [""]), 0)
}

output "autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = element(concat(aws_autoscaling_group.this.*.name, [""]), 0)
}

output "autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = element(concat(aws_autoscaling_group.this.*.arn, [""]), 0)
}

output "autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = element(concat(aws_autoscaling_group.this.*.min_size, [""]), 0)
}

output "autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = element(concat(aws_autoscaling_group.this.*.max_size, [""]), 0)
}

output "autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = element(concat(aws_autoscaling_group.this.*.desired_capacity, [""]), 0)
}

output "autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = element(concat(aws_autoscaling_group.this.*.default_cooldown, [""]), 0)
}

output "autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = element(concat(aws_autoscaling_group.this.*.health_check_grace_period, [""]), 0)
}

output "autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = element(concat(aws_autoscaling_group.this.*.health_check_type, [""]), 0)
}

output "autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = element(concat(aws_autoscaling_group.this.*.availability_zones, [""]), 0)
}

output "autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = element(concat(aws_autoscaling_group.this.*.vpc_zone_identifier, [""]), 0)
}

output "autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = element(concat(aws_autoscaling_group.this.*.load_balancers, [""]), 0)
}

output "autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = element(concat(aws_autoscaling_group.this.*.target_group_arns, [""]), 0)
}
