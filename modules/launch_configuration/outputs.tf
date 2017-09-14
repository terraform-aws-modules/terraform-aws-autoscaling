# Launch configuration
output "this_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = "${var.count == 0 ? "" : aws_launch_configuration.this.id}"
}

output "this_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = "${var.count == 0 ? "" : aws_launch_configuration.this.name}"
}
