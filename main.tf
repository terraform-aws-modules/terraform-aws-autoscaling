#######################
# Launch template
#######################
resource "aws_launch_template" "this" {
  count = var.create_lt ? 1 : 0

  name_prefix   = "${coalesce(var.lt_name, var.name)}-"
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(var.user_data)
  ebs_optimized = var.ebs_optimized
  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name  = lookup(block_device_mappings.value, "device_name", null)
      no_device    = lookup(block_device_mappings.value, "no_device", null)
      virtual_name = lookup(block_device_mappings.value, "virtual_name", null)

      dynamic "ebs" {
        for_each = lookup(block_device_mappings.value, "ebs", [])
        content {
          delete_on_termination = lookup(ebs.value, "delete_on_termination", null)
          encrypted             = lookup(ebs.value, "encrypted", null)
          iops                  = lookup(ebs.value, "iops", null)
          kms_key_id            = lookup(ebs.value, "kms_key_id", null)
          snapshot_id           = lookup(ebs.value, "snapshot_id", null)
          volume_size           = lookup(ebs.value, "volume_size", null)
          volume_type           = lookup(ebs.value, "volume_type", null)
        }
      }
    }
  }

  iam_instance_profile {
    arn = var.iam_instance_profile
  }

  network_interfaces {
    description                 = coalesce(var.lt_name, var.name)
    device_index                = 0
    associate_public_ip_address = var.associate_public_ip_address
    delete_on_termination       = true
    security_groups             = var.security_groups
  }

  monitoring {
    enabled = var.enable_monitoring
  }

  placement {
    tenancy = var.spot_price == "" ? "default" : var.placement_tenancy
  }

  tag_specifications {
    resource_type = "instance"
    tags          = var.tags_as_map
  }

  tag_specifications {
    resource_type = "volume"
    tags          = var.tags_as_map
  }

  # Create block when var.spot_price is set, else make it run on-demand to mimic behaviour of v3.x
  dynamic "instance_market_options" {
    for_each = var.spot_price != "" ? [var.spot_price] : []
    content {
      market_type = "spot"
      spot_options {
        max_price = instance_market_options.value
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

####################
# Autoscaling group
####################
resource "aws_autoscaling_group" "this" {
  count = var.create_asg && false == var.create_asg_with_initial_lifecycle_hook ? 1 : 0

  name_prefix = "${join(
    "-",
    compact(
      [
        coalesce(var.asg_name, var.name),
        var.recreate_asg_when_lt_changes ? element(concat(random_pet.asg_name.*.id, [""]), 0) : "",
      ],
    ),
  )}-"
  vpc_zone_identifier = var.vpc_zone_identifier
  max_size            = var.max_size
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity

  load_balancers            = var.load_balancers
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type

  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  target_group_arns         = var.target_group_arns
  default_cooldown          = var.default_cooldown
  force_delete              = var.force_delete
  termination_policies      = var.termination_policies
  suspended_processes       = var.suspended_processes
  placement_group           = var.placement_group
  enabled_metrics           = var.enabled_metrics
  metrics_granularity       = var.metrics_granularity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  protect_from_scale_in     = var.protect_from_scale_in
  service_linked_role_arn   = var.service_linked_role_arn

  launch_template {
    id      = var.create_lt ? element(concat(aws_launch_template.this.*.id, [""]), 0) : var.launch_template
    version = "$Latest"
  }

  tags = concat(
    [
      {
        key                 = "Name"
        value               = var.name
        propagate_at_launch = true
      },
    ],
    var.tags,
    local.tags_asg_format,
  )

  lifecycle {
    create_before_destroy = true
  }
}

################################################
# Autoscaling group with initial lifecycle hook
################################################
resource "aws_autoscaling_group" "this_with_initial_lifecycle_hook" {
  count = var.create_asg && var.create_asg_with_initial_lifecycle_hook ? 1 : 0

  name_prefix = "${join(
    "-",
    compact(
      [
        coalesce(var.asg_name, var.name),
        var.recreate_asg_when_lt_changes ? element(concat(random_pet.asg_name.*.id, [""]), 0) : "",
      ],
    ),
  )}-"
  vpc_zone_identifier = var.vpc_zone_identifier
  max_size            = var.max_size
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity

  load_balancers            = var.load_balancers
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type

  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  target_group_arns         = var.target_group_arns
  default_cooldown          = var.default_cooldown
  force_delete              = var.force_delete
  termination_policies      = var.termination_policies
  suspended_processes       = var.suspended_processes
  placement_group           = var.placement_group
  enabled_metrics           = var.enabled_metrics
  metrics_granularity       = var.metrics_granularity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  protect_from_scale_in     = var.protect_from_scale_in
  service_linked_role_arn   = var.service_linked_role_arn

  initial_lifecycle_hook {
    name                    = var.initial_lifecycle_hook_name
    lifecycle_transition    = var.initial_lifecycle_hook_lifecycle_transition
    notification_metadata   = var.initial_lifecycle_hook_notification_metadata
    heartbeat_timeout       = var.initial_lifecycle_hook_heartbeat_timeout
    notification_target_arn = var.initial_lifecycle_hook_notification_target_arn
    role_arn                = var.initial_lifecycle_hook_role_arn
    default_result          = var.initial_lifecycle_hook_default_result
  }

  launch_template {
    id      = var.create_lt ? element(concat(aws_launch_template.this.*.id, [""]), 0) : var.launch_template
    version = "$Latest"
  }

  tags = concat(
    [
      {
        key                 = "Name"
        value               = var.name
        propagate_at_launch = true
      },
    ],
    var.tags,
    local.tags_asg_format,
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "random_pet" "asg_name" {
  count = var.recreate_asg_when_lt_changes ? 1 : 0

  separator = "-"
  length    = 2

  keepers = {
    # Generate a new pet name each time we switch launch template
    lt_name = var.create_lt ? element(concat(aws_launch_template.this.*.name, [""]), 0) : var.launch_template
  }
}
