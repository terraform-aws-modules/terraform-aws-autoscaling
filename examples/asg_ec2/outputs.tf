output "this_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = module.example.this_launch_configuration_id
}

output "this_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.example.this_autoscaling_group_id
}

output "this_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.example.this_autoscaling_group_availability_zones
}

output "this_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.example.this_autoscaling_group_vpc_zone_identifier
}

output "this_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.example.this_autoscaling_group_load_balancers
}

output "this_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.example.this_autoscaling_group_target_group_arns
}
