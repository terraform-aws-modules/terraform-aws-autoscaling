data "aws_partition" "current" {}
data "aws_default_tags" "current" {}

locals {
  create = var.create && var.putin_khuylo

  launch_template_name    = coalesce(var.launch_template_name, var.name)
  launch_template         = var.create_launch_template ? aws_launch_template.this[0].name : var.launch_template
  launch_template_version = var.create_launch_template && var.launch_template_version == null ? aws_launch_template.this[0].latest_version : var.launch_template_version

  asg_tags = merge(
    data.aws_default_tags.current.tags,
    var.tags,
    { "Name" = coalesce(var.instance_name, var.name) },
    var.autoscaling_group_tags,
  )
}

################################################################################
# Launch template
################################################################################

locals {
  iam_instance_profile_arn  = var.create_iam_instance_profile ? aws_iam_instance_profile.this[0].arn : var.iam_instance_profile_arn
  iam_instance_profile_name = !var.create_iam_instance_profile && var.iam_instance_profile_arn == null ? var.iam_instance_profile_name : null
}

resource "aws_launch_template" "this" {
  count = var.create_launch_template ? 1 : 0

  name        = var.launch_template_use_name_prefix ? null : local.launch_template_name
  name_prefix = var.launch_template_use_name_prefix ? "${local.launch_template_name}-" : null
  description = var.launch_template_description

  ebs_optimized = var.ebs_optimized
  image_id      = var.image_id
  key_name      = var.key_name
  user_data     = var.user_data

  # Ref: https://github.com/hashicorp/terraform-provider-aws/issues/4570
  vpc_security_group_ids = length(var.network_interfaces) > 0 ? [] : var.security_groups

  default_version                      = var.default_version
  update_default_version               = var.update_default_version
  disable_api_termination              = var.disable_api_termination
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  kernel_id                            = var.kernel_id
  ram_disk_id                          = var.ram_disk_id

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name  = block_device_mappings.value.device_name
      no_device    = try(block_device_mappings.value.no_device, null)
      virtual_name = try(block_device_mappings.value.virtual_name, null)

      dynamic "ebs" {
        for_each = flatten([try(block_device_mappings.value.ebs, [])])
        content {
          delete_on_termination = try(ebs.value.delete_on_termination, null)
          encrypted             = try(ebs.value.encrypted, null)
          kms_key_id            = try(ebs.value.kms_key_id, null)
          iops                  = try(ebs.value.iops, null)
          throughput            = try(ebs.value.throughput, null)
          snapshot_id           = try(ebs.value.snapshot_id, null)
          volume_size           = try(ebs.value.volume_size, null)
          volume_type           = try(ebs.value.volume_type, null)
        }
      }
    }
  }

  dynamic "capacity_reservation_specification" {
    for_each = length(var.capacity_reservation_specification) > 0 ? [var.capacity_reservation_specification] : []
    content {
      capacity_reservation_preference = try(capacity_reservation_specification.value.capacity_reservation_preference, null)

      dynamic "capacity_reservation_target" {
        for_each = try([capacity_reservation_specification.value.capacity_reservation_target], [])
        content {
          capacity_reservation_id                 = try(capacity_reservation_target.value.capacity_reservation_id, null)
          capacity_reservation_resource_group_arn = try(capacity_reservation_target.value.capacity_reservation_resource_group_arn, null)
        }
      }
    }
  }

  dynamic "cpu_options" {
    for_each = length(var.cpu_options) > 0 ? [var.cpu_options] : []
    content {
      core_count       = cpu_options.value.core_count
      threads_per_core = cpu_options.value.threads_per_core
    }
  }

  dynamic "credit_specification" {
    for_each = length(var.credit_specification) > 0 ? [var.credit_specification] : []
    content {
      cpu_credits = credit_specification.value.cpu_credits
    }
  }

  dynamic "elastic_gpu_specifications" {
    for_each = length(var.elastic_gpu_specifications) > 0 ? [var.elastic_gpu_specifications] : []
    content {
      type = elastic_gpu_specifications.value.type
    }
  }

  dynamic "elastic_inference_accelerator" {
    for_each = length(var.elastic_inference_accelerator) > 0 ? [var.elastic_inference_accelerator] : []
    content {
      type = elastic_inference_accelerator.value.type
    }
  }

  dynamic "enclave_options" {
    for_each = length(var.enclave_options) > 0 ? [var.enclave_options] : []
    content {
      enabled = enclave_options.value.enabled
    }
  }

  dynamic "hibernation_options" {
    for_each = length(var.hibernation_options) > 0 ? [var.hibernation_options] : []
    content {
      configured = hibernation_options.value.configured
    }
  }

  dynamic "iam_instance_profile" {
    for_each = local.iam_instance_profile_name != null || local.iam_instance_profile_arn != null ? [1] : []
    content {
      name = local.iam_instance_profile_name
      arn  = local.iam_instance_profile_arn
    }
  }

  dynamic "instance_market_options" {
    for_each = length(var.instance_market_options) > 0 ? [var.instance_market_options] : []
    content {
      market_type = instance_market_options.value.market_type

      dynamic "spot_options" {
        for_each = try([instance_market_options.value.spot_options], [])
        content {
          block_duration_minutes         = try(spot_options.value.block_duration_minutes, null)
          instance_interruption_behavior = try(spot_options.value.instance_interruption_behavior, null)
          max_price                      = try(spot_options.value.max_price, null)
          spot_instance_type             = try(spot_options.value.spot_instance_type, null)
          valid_until                    = try(spot_options.value.valid_until, null)
        }
      }
    }
  }

  instance_type = var.instance_type

  dynamic "instance_requirements" {
    for_each = length(var.instance_requirements) > 0 ? [var.instance_requirements] : []
    content {

      dynamic "accelerator_count" {
        for_each = try([instance_requirements.value.accelerator_count], [])
        content {
          max = try(accelerator_count.value.max, null)
          min = try(accelerator_count.value.min, null)
        }
      }

      accelerator_manufacturers = try(instance_requirements.value.accelerator_manufacturers, [])
      accelerator_names         = try(instance_requirements.value.accelerator_names, [])

      dynamic "accelerator_total_memory_mib" {
        for_each = try([instance_requirements.value.accelerator_total_memory_mib], [])
        content {
          max = try(accelerator_total_memory_mib.value.max, null)
          min = try(accelerator_total_memory_mib.value.min, null)
        }
      }

      accelerator_types = try(instance_requirements.value.accelerator_types, [])
      bare_metal        = try(instance_requirements.value.bare_metal, null)

      dynamic "baseline_ebs_bandwidth_mbps" {
        for_each = try([instance_requirements.value.baseline_ebs_bandwidth_mbps], [])
        content {
          max = try(baseline_ebs_bandwidth_mbps.value.max, null)
          min = try(baseline_ebs_bandwidth_mbps.value.min, null)
        }
      }

      burstable_performance   = try(instance_requirements.value.burstable_performance, null)
      cpu_manufacturers       = try(instance_requirements.value.cpu_manufacturers, [])
      excluded_instance_types = try(instance_requirements.value.excluded_instance_types, [])
      instance_generations    = try(instance_requirements.value.instance_generations, [])
      local_storage           = try(instance_requirements.value.local_storage, null)
      local_storage_types     = try(instance_requirements.value.local_storage_types, [])

      dynamic "memory_gib_per_vcpu" {
        for_each = try([instance_requirements.value.memory_gib_per_vcpu], [])
        content {
          max = try(memory_gib_per_vcpu.value.max, null)
          min = try(memory_gib_per_vcpu.value.min, null)
        }
      }

      dynamic "memory_mib" {
        for_each = [instance_requirements.value.memory_mib]
        content {
          max = try(memory_mib.value.max, null)
          min = memory_mib.value.min
        }
      }

      dynamic "network_interface_count" {
        for_each = try([instance_requirements.value.network_interface_count], [])
        content {
          max = try(network_interface_count.value.max, null)
          min = try(network_interface_count.value.min, null)
        }
      }

      on_demand_max_price_percentage_over_lowest_price = try(instance_requirements.value.on_demand_max_price_percentage_over_lowest_price, null)
      require_hibernate_support                        = try(instance_requirements.value.require_hibernate_support, null)
      spot_max_price_percentage_over_lowest_price      = try(instance_requirements.value.spot_max_price_percentage_over_lowest_price, null)

      dynamic "total_local_storage_gb" {
        for_each = try([instance_requirements.value.total_local_storage_gb], [])
        content {
          max = try(total_local_storage_gb.value.max, null)
          min = try(total_local_storage_gb.value.min, null)
        }
      }

      dynamic "vcpu_count" {
        for_each = [instance_requirements.value.vcpu_count]
        content {
          max = try(vcpu_count.value.max, null)
          min = vcpu_count.value.min
        }
      }
    }
  }

  dynamic "license_specification" {
    for_each = length(var.license_specifications) > 0 ? [var.license_specifications] : []
    content {
      license_configuration_arn = license_specifications.value.license_configuration_arn
    }
  }

  dynamic "maintenance_options" {
    for_each = length(var.maintenance_options) > 0 ? [var.maintenance_options] : []
    content {
      auto_recovery = try(maintenance_options.value.auto_recovery, null)
    }
  }

  dynamic "metadata_options" {
    for_each = length(var.metadata_options) > 0 ? [var.metadata_options] : []
    content {
      http_endpoint               = try(metadata_options.value.http_endpoint, null)
      http_tokens                 = try(metadata_options.value.http_tokens, null)
      http_put_response_hop_limit = try(metadata_options.value.http_put_response_hop_limit, null)
      http_protocol_ipv6          = try(metadata_options.value.http_protocol_ipv6, null)
      instance_metadata_tags      = try(metadata_options.value.instance_metadata_tags, null)
    }
  }

  dynamic "monitoring" {
    for_each = var.enable_monitoring ? [1] : []
    content {
      enabled = var.enable_monitoring
    }
  }

  dynamic "network_interfaces" {
    for_each = var.network_interfaces
    content {
      associate_carrier_ip_address = try(network_interfaces.value.associate_carrier_ip_address, null)
      associate_public_ip_address  = try(network_interfaces.value.associate_public_ip_address, null)
      delete_on_termination        = try(network_interfaces.value.delete_on_termination, null)
      description                  = try(network_interfaces.value.description, null)
      device_index                 = try(network_interfaces.value.device_index, null)
      interface_type               = try(network_interfaces.value.interface_type, null)
      ipv4_prefix_count            = try(network_interfaces.value.ipv4_prefix_count, null)
      ipv4_prefixes                = try(network_interfaces.value.ipv4_prefixes, null)
      ipv4_addresses               = try(network_interfaces.value.ipv4_addresses, [])
      ipv4_address_count           = try(network_interfaces.value.ipv4_address_count, null)
      ipv6_prefix_count            = try(network_interfaces.value.ipv6_prefix_count, null)
      ipv6_prefixes                = try(network_interfaces.value.ipv6_prefixes, [])
      ipv6_addresses               = try(network_interfaces.value.ipv6_addresses, [])
      ipv6_address_count           = try(network_interfaces.value.ipv6_address_count, null)
      network_interface_id         = try(network_interfaces.value.network_interface_id, null)
      network_card_index           = try(network_interfaces.value.network_card_index, null)
      private_ip_address           = try(network_interfaces.value.private_ip_address, null)
      # Ref: https://github.com/hashicorp/terraform-provider-aws/issues/4570
      security_groups = compact(concat(try(network_interfaces.value.security_groups, []), var.security_groups))
      subnet_id       = try(network_interfaces.value.subnet_id, null)
    }
  }

  dynamic "placement" {
    for_each = length(var.placement) > 0 ? [var.placement] : []
    content {
      affinity                = try(placement.value.affinity, null)
      availability_zone       = try(placement.value.availability_zone, null)
      group_name              = try(placement.value.group_name, null)
      host_id                 = try(placement.value.host_id, null)
      host_resource_group_arn = try(placement.value.host_resource_group_arn, null)
      spread_domain           = try(placement.value.spread_domain, null)
      tenancy                 = try(placement.value.tenancy, null)
      partition_number        = try(placement.value.partition_number, null)
    }
  }

  dynamic "private_dns_name_options" {
    for_each = length(var.private_dns_name_options) > 0 ? [var.private_dns_name_options] : []
    content {
      enable_resource_name_dns_aaaa_record = try(private_dns_name_options.value.enable_resource_name_dns_aaaa_record, null)
      enable_resource_name_dns_a_record    = try(private_dns_name_options.value.enable_resource_name_dns_a_record, null)
      hostname_type                        = private_dns_name_options.value.hostname_type
    }
  }

  dynamic "tag_specifications" {
    for_each = var.tag_specifications
    content {
      resource_type = tag_specifications.value.resource_type
      tags          = merge(var.tags, tag_specifications.value.tags)
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

################################################################################
# Autoscaling group - default
################################################################################

resource "aws_autoscaling_group" "this" {
  count = local.create && !var.ignore_desired_capacity_changes ? 1 : 0

  name        = var.use_name_prefix ? null : var.name
  name_prefix = var.use_name_prefix ? "${var.name}-" : null

  dynamic "launch_template" {
    for_each = var.use_mixed_instances_policy ? [] : [1]

    content {
      name    = local.launch_template
      version = local.launch_template_version
    }
  }

  availability_zones  = var.availability_zones
  vpc_zone_identifier = var.vpc_zone_identifier

  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  capacity_rebalance        = var.capacity_rebalance
  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  default_cooldown          = var.default_cooldown
  protect_from_scale_in     = var.protect_from_scale_in

  load_balancers            = var.load_balancers
  target_group_arns         = var.target_group_arns
  placement_group           = var.placement_group
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  force_delete          = var.force_delete
  termination_policies  = var.termination_policies
  suspended_processes   = var.suspended_processes
  max_instance_lifetime = var.max_instance_lifetime

  enabled_metrics         = var.enabled_metrics
  metrics_granularity     = var.metrics_granularity
  service_linked_role_arn = var.service_linked_role_arn

  dynamic "initial_lifecycle_hook" {
    for_each = var.initial_lifecycle_hooks
    content {
      name                    = initial_lifecycle_hook.value.name
      default_result          = try(initial_lifecycle_hook.value.default_result, null)
      heartbeat_timeout       = try(initial_lifecycle_hook.value.heartbeat_timeout, null)
      lifecycle_transition    = initial_lifecycle_hook.value.lifecycle_transition
      notification_metadata   = try(initial_lifecycle_hook.value.notification_metadata, null)
      notification_target_arn = try(initial_lifecycle_hook.value.notification_target_arn, null)
      role_arn                = try(initial_lifecycle_hook.value.role_arn, null)
    }
  }

  dynamic "instance_refresh" {
    for_each = length(var.instance_refresh) > 0 ? [var.instance_refresh] : []
    content {
      strategy = instance_refresh.value.strategy
      triggers = try(instance_refresh.value.triggers, null)

      dynamic "preferences" {
        for_each = try([instance_refresh.value.preferences], [])
        content {
          checkpoint_delay       = try(preferences.value.checkpoint_delay, null)
          checkpoint_percentages = try(preferences.value.checkpoint_percentages, null)
          instance_warmup        = try(preferences.value.instance_warmup, null)
          min_healthy_percentage = try(preferences.value.min_healthy_percentage, null)
        }
      }
    }
  }

  dynamic "mixed_instances_policy" {
    for_each = var.use_mixed_instances_policy ? [var.mixed_instances_policy] : []
    content {
      dynamic "instances_distribution" {
        for_each = try([mixed_instances_policy.value.instances_distribution], [])
        content {
          on_demand_allocation_strategy            = try(instances_distribution.value.on_demand_allocation_strategy, null)
          on_demand_base_capacity                  = try(instances_distribution.value.on_demand_base_capacity, null)
          on_demand_percentage_above_base_capacity = try(instances_distribution.value.on_demand_percentage_above_base_capacity, null)
          spot_allocation_strategy                 = try(instances_distribution.value.spot_allocation_strategy, null)
          spot_instance_pools                      = try(instances_distribution.value.spot_instance_pools, null)
          spot_max_price                           = try(instances_distribution.value.spot_max_price, null)
        }
      }

      launch_template {
        launch_template_specification {
          launch_template_name = local.launch_template
          version              = local.launch_template_version
        }

        dynamic "override" {
          for_each = try(mixed_instances_policy.value.override, [])
          content {
            instance_type     = try(override.value.instance_type, null)
            weighted_capacity = try(override.value.weighted_capacity, null)

            dynamic "launch_template_specification" {
              for_each = try([override.value.launch_template_specification], [])
              content {
                launch_template_id = try(launch_template_specification.value.launch_template_id, null)
              }
            }
          }
        }
      }
    }
  }

  dynamic "warm_pool" {
    for_each = length(var.warm_pool) > 0 ? [var.warm_pool] : []
    content {
      pool_state                  = try(warm_pool.value.pool_state, null)
      min_size                    = try(warm_pool.value.min_size, null)
      max_group_prepared_capacity = try(warm_pool.value.max_group_prepared_capacity, null)

      dynamic "instance_reuse_policy" {
        for_each = try([warm_pool.value.instance_reuse_policy], [])
        content {
          reuse_on_scale_in = try(instance_reuse_policy.value.reuse_on_scale_in, null)
        }
      }
    }
  }

  timeouts {
    delete = var.delete_timeout
  }

  dynamic "tag" {
    for_each = local.asg_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

################################################################################
# Autoscaling group - ignore desired capacity
################################################################################

resource "aws_autoscaling_group" "idc" {
  count = local.create && var.ignore_desired_capacity_changes ? 1 : 0

  name        = var.use_name_prefix ? null : var.name
  name_prefix = var.use_name_prefix ? "${var.name}-" : null

  dynamic "launch_template" {
    for_each = var.use_mixed_instances_policy ? [] : [1]

    content {
      name    = local.launch_template
      version = local.launch_template_version
    }
  }

  availability_zones  = var.availability_zones
  vpc_zone_identifier = var.vpc_zone_identifier

  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  capacity_rebalance        = var.capacity_rebalance
  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  default_cooldown          = var.default_cooldown
  protect_from_scale_in     = var.protect_from_scale_in

  load_balancers            = var.load_balancers
  target_group_arns         = var.target_group_arns
  placement_group           = var.placement_group
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  force_delete          = var.force_delete
  termination_policies  = var.termination_policies
  suspended_processes   = var.suspended_processes
  max_instance_lifetime = var.max_instance_lifetime

  enabled_metrics         = var.enabled_metrics
  metrics_granularity     = var.metrics_granularity
  service_linked_role_arn = var.service_linked_role_arn

  dynamic "initial_lifecycle_hook" {
    for_each = var.initial_lifecycle_hooks
    content {
      name                    = initial_lifecycle_hook.value.name
      default_result          = try(initial_lifecycle_hook.value.default_result, null)
      heartbeat_timeout       = try(initial_lifecycle_hook.value.heartbeat_timeout, null)
      lifecycle_transition    = initial_lifecycle_hook.value.lifecycle_transition
      notification_metadata   = try(initial_lifecycle_hook.value.notification_metadata, null)
      notification_target_arn = try(initial_lifecycle_hook.value.notification_target_arn, null)
      role_arn                = try(initial_lifecycle_hook.value.role_arn, null)
    }
  }

  dynamic "instance_refresh" {
    for_each = length(var.instance_refresh) > 0 ? [var.instance_refresh] : []
    content {
      strategy = instance_refresh.value.strategy
      triggers = try(instance_refresh.value.triggers, null)

      dynamic "preferences" {
        for_each = try([instance_refresh.value.preferences], [])
        content {
          checkpoint_delay       = try(preferences.value.checkpoint_delay, null)
          checkpoint_percentages = try(preferences.value.checkpoint_percentages, null)
          instance_warmup        = try(preferences.value.instance_warmup, null)
          min_healthy_percentage = try(preferences.value.min_healthy_percentage, null)
        }
      }
    }
  }

  dynamic "mixed_instances_policy" {
    for_each = var.use_mixed_instances_policy ? [var.mixed_instances_policy] : []
    content {
      dynamic "instances_distribution" {
        for_each = try([mixed_instances_policy.value.instances_distribution], [])
        content {
          on_demand_allocation_strategy            = try(instances_distribution.value.on_demand_allocation_strategy, null)
          on_demand_base_capacity                  = try(instances_distribution.value.on_demand_base_capacity, null)
          on_demand_percentage_above_base_capacity = try(instances_distribution.value.on_demand_percentage_above_base_capacity, null)
          spot_allocation_strategy                 = try(instances_distribution.value.spot_allocation_strategy, null)
          spot_instance_pools                      = try(instances_distribution.value.spot_instance_pools, null)
          spot_max_price                           = try(instances_distribution.value.spot_max_price, null)
        }
      }

      launch_template {
        launch_template_specification {
          launch_template_name = local.launch_template
          version              = local.launch_template_version
        }

        dynamic "override" {
          for_each = try(mixed_instances_policy.value.override, [])
          content {
            instance_type     = try(override.value.instance_type, null)
            weighted_capacity = try(override.value.weighted_capacity, null)

            dynamic "launch_template_specification" {
              for_each = try([override.value.launch_template_specification], [])
              content {
                launch_template_id = try(launch_template_specification.value.launch_template_id, null)
              }
            }
          }
        }
      }
    }
  }

  dynamic "warm_pool" {
    for_each = length(var.warm_pool) > 0 ? [var.warm_pool] : []
    content {
      pool_state                  = try(warm_pool.value.pool_state, null)
      min_size                    = try(warm_pool.value.min_size, null)
      max_group_prepared_capacity = try(warm_pool.value.max_group_prepared_capacity, null)

      dynamic "instance_reuse_policy" {
        for_each = try([warm_pool.value.instance_reuse_policy], [])
        content {
          reuse_on_scale_in = try(instance_reuse_policy.value.reuse_on_scale_in, null)
        }
      }
    }
  }

  timeouts {
    delete = var.delete_timeout
  }

  dynamic "tag" {
    for_each = local.asg_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }
}

################################################################################
# Autoscaling group schedule
################################################################################

resource "aws_autoscaling_schedule" "this" {
  for_each = local.create && var.create_schedule ? var.schedules : {}

  scheduled_action_name  = each.key
  autoscaling_group_name = try(aws_autoscaling_group.this[0].name, aws_autoscaling_group.idc[0].name)

  min_size         = try(each.value.min_size, null)
  max_size         = try(each.value.max_size, null)
  desired_capacity = try(each.value.desired_capacity, null)
  start_time       = try(each.value.start_time, null)
  end_time         = try(each.value.end_time, null)
  time_zone        = try(each.value.time_zone, null)

  # [Minute] [Hour] [Day_of_Month] [Month_of_Year] [Day_of_Week]
  # Cron examples: https://crontab.guru/examples.html
  recurrence = try(each.value.recurrence, null)
}

################################################################################
# Autoscaling Policy
################################################################################

resource "aws_autoscaling_policy" "this" {
  for_each = { for k, v in var.scaling_policies : k => v if local.create && var.create_scaling_policy }

  name                   = try(each.value.name, each.key)
  autoscaling_group_name = var.ignore_desired_capacity_changes ? aws_autoscaling_group.idc[0].name : aws_autoscaling_group.this[0].name

  adjustment_type           = try(each.value.adjustment_type, null)
  policy_type               = try(each.value.policy_type, null)
  estimated_instance_warmup = try(each.value.estimated_instance_warmup, null)
  cooldown                  = try(each.value.cooldown, null)
  min_adjustment_magnitude  = try(each.value.min_adjustment_magnitude, null)
  metric_aggregation_type   = try(each.value.metric_aggregation_type, null)
  scaling_adjustment        = try(each.value.scaling_adjustment, null)

  dynamic "step_adjustment" {
    for_each = try([each.value.step_adjustment], [])
    content {
      scaling_adjustment          = step_adjustment.value.scaling_adjustment
      metric_interval_lower_bound = try(step_adjustment.value.metric_interval_lower_bound, null)
      metric_interval_upper_bound = try(step_adjustment.value.metric_interval_upper_bound, null)
    }
  }

  dynamic "target_tracking_configuration" {
    for_each = try([each.value.target_tracking_configuration], [])
    content {
      target_value     = target_tracking_configuration.value.target_value
      disable_scale_in = try(target_tracking_configuration.value.disable_scale_in, null)

      dynamic "predefined_metric_specification" {
        for_each = try([target_tracking_configuration.value.predefined_metric_specification], [])
        content {
          predefined_metric_type = predefined_metric_specification.value.predefined_metric_type
          resource_label         = try(predefined_metric_specification.value.resource_label, null)
        }
      }

      dynamic "customized_metric_specification" {
        for_each = try([target_tracking_configuration.value.customized_metric_specification], [])
        content {

          dynamic "metric_dimension" {
            for_each = try([customized_metric_specification.value.metric_dimension], [])
            content {
              name  = try(metric_dimension.value.name, null)
              value = try(metric_dimension.value.value, null)
            }
          }

          metric_name = customized_metric_specification.value.metric_name
          namespace   = customized_metric_specification.value.namespace
          statistic   = customized_metric_specification.value.statistic
          unit        = try(customized_metric_specification.value.unit, null)
        }
      }
    }
  }

  dynamic "predictive_scaling_configuration" {
    for_each = try([each.value.predictive_scaling_configuration], [])
    content {
      max_capacity_breach_behavior = try(predictive_scaling_configuration.value.max_capacity_breach_behavior, null)
      max_capacity_buffer          = try(predictive_scaling_configuration.value.max_capacity_buffer, null)
      mode                         = try(predictive_scaling_configuration.value.mode, null)
      scheduling_buffer_time       = try(predictive_scaling_configuration.value.scheduling_buffer_time, null)

      dynamic "metric_specification" {
        for_each = try([predictive_scaling_configuration.value.metric_specification], [])
        content {
          target_value = metric_specification.value.target_value

          dynamic "predefined_load_metric_specification" {
            for_each = try([metric_specification.value.predefined_load_metric_specification], [])
            content {
              predefined_metric_type = predefined_load_metric_specification.value.predefined_metric_type
              resource_label         = predefined_load_metric_specification.value.resource_label
            }
          }

          dynamic "predefined_metric_pair_specification" {
            for_each = try([metric_specification.value.predefined_metric_pair_specification], [])
            content {
              predefined_metric_type = predefined_metric_pair_specification.value.predefined_metric_type
              resource_label         = predefined_metric_pair_specification.value.resource_label
            }
          }

          dynamic "predefined_scaling_metric_specification" {
            for_each = try([metric_specification.value.predefined_scaling_metric_specification], [])
            content {
              predefined_metric_type = predefined_scaling_metric_specification.value.predefined_metric_type
              resource_label         = predefined_scaling_metric_specification.value.resource_label
            }
          }
        }
      }
    }
  }
}

################################################################################
# IAM Role / Instance Profile
################################################################################

locals {
  internal_iam_instance_profile_name = try(coalesce(var.iam_instance_profile_name, var.iam_role_name), "")
}

data "aws_iam_policy_document" "assume_role_policy" {
  count = local.create && var.create_iam_instance_profile ? 1 : 0

  statement {
    sid     = "EC2AssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

resource "aws_iam_role" "this" {
  count = local.create && var.create_iam_instance_profile ? 1 : 0

  name        = var.iam_role_use_name_prefix ? null : local.internal_iam_instance_profile_name
  name_prefix = var.iam_role_use_name_prefix ? "${local.internal_iam_instance_profile_name}-" : null
  path        = var.iam_role_path
  description = var.iam_role_description

  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy[0].json
  permissions_boundary  = var.iam_role_permissions_boundary
  force_detach_policies = true

  tags = merge(var.tags, var.iam_role_tags)
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for k, v in var.iam_role_policies : k => v if var.create && var.create_iam_instance_profile }

  policy_arn = each.value
  role       = aws_iam_role.this[0].name
}

resource "aws_iam_instance_profile" "this" {
  count = local.create && var.create_iam_instance_profile ? 1 : 0

  role = aws_iam_role.this[0].name

  name        = var.iam_role_use_name_prefix ? null : var.iam_role_name
  name_prefix = var.iam_role_use_name_prefix ? "${var.iam_role_name}-" : null
  path        = var.iam_role_path

  tags = merge(var.tags, var.iam_role_tags)
}
