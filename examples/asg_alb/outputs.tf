# Launch configuration
output "this_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = module.example_asg.this_launch_configuration_id
}

# Autoscaling group
output "this_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.example_asg.this_autoscaling_group_id
}


