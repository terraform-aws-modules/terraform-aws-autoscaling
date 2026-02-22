data "aws_partition" "current" {}

locals {
  create = var.create && var.putin_khuylo

  launch_template_name    = coalesce(var.launch_template_name, var.name)
  launch_template_id      = var.create_launch_template ? aws_launch_template.this[0].id : var.launch_template_id
  launch_template_version = var.create_launch_template && var.launch_template_version == null ? aws_launch_template.this[0].latest_version : var.launch_template_version

  autoscaling_group_tags = merge(
    var.tags,
    { "Name" = coalesce(var.instance_name, var.name) },
    var.autoscaling_group_tags,
  )
}

################################################################################
# Autoscaling group - default
################################################################################

resource "aws_autoscaling_group" "this" {
  count = local.create && !var.ignore_desired_capacity_changes ? 1 : 0

  region = var.region

  availability_zones = var.availability_zones

  dynamic "availability_zone_distribution" {
    for_each = var.availability_zone_distribution != null ? [var.availability_zone_distribution] : []

    content {
      capacity_distribution_strategy = availability_zone_distribution.value.capacity_distribution_strategy
    }
  }

  capacity_rebalance = var.capacity_rebalance
  # capacity_reservation_specification set on launch template
  context                          = var.context
  default_cooldown                 = var.default_cooldown
  default_instance_warmup          = var.default_instance_warmup
  desired_capacity                 = var.desired_capacity
  desired_capacity_type            = var.desired_capacity_type
  enabled_metrics                  = var.enabled_metrics
  force_delete                     = var.force_delete
  force_delete_warm_pool           = var.force_delete_warm_pool
  health_check_grace_period        = var.health_check_grace_period
  health_check_type                = var.health_check_type
  ignore_failed_scaling_activities = var.ignore_failed_scaling_activities

  dynamic "initial_lifecycle_hook" {
    for_each = var.initial_lifecycle_hooks != null ? var.initial_lifecycle_hooks : []

    content {
      default_result          = initial_lifecycle_hook.value.default_result
      heartbeat_timeout       = initial_lifecycle_hook.value.heartbeat_timeout
      lifecycle_transition    = initial_lifecycle_hook.value.lifecycle_transition
      name                    = initial_lifecycle_hook.value.name
      notification_metadata   = initial_lifecycle_hook.value.notification_metadata
      notification_target_arn = initial_lifecycle_hook.value.notification_target_arn
      role_arn                = initial_lifecycle_hook.value.role_arn
    }
  }

  dynamic "instance_maintenance_policy" {
    for_each = var.instance_maintenance_policy != null ? [var.instance_maintenance_policy] : []

    content {
      min_healthy_percentage = instance_maintenance_policy.value.min_healthy_percentage
      max_healthy_percentage = instance_maintenance_policy.value.max_healthy_percentage
    }
  }

  dynamic "instance_refresh" {
    for_each = var.instance_refresh != null ? [var.instance_refresh] : []

    content {
      dynamic "preferences" {
        for_each = instance_refresh.value.preferences != null ? [instance_refresh.value.preferences] : []

        content {
          dynamic "alarm_specification" {
            for_each = preferences.value.alarm_specification != null ? [preferences.value.alarm_specification] : []

            content {
              alarms = alarm_specification.value.alarms
            }
          }

          auto_rollback                = preferences.value.auto_rollback
          checkpoint_delay             = preferences.value.checkpoint_delay
          checkpoint_percentages       = preferences.value.checkpoint_percentages
          instance_warmup              = preferences.value.instance_warmup
          max_healthy_percentage       = preferences.value.max_healthy_percentage
          min_healthy_percentage       = preferences.value.min_healthy_percentage
          scale_in_protected_instances = preferences.value.scale_in_protected_instances
          skip_matching                = preferences.value.skip_matching
          standby_instances            = preferences.value.standby_instances
        }
      }

      strategy = instance_refresh.value.strategy
      triggers = instance_refresh.value.triggers
    }
  }

  dynamic "launch_template" {
    for_each = var.use_mixed_instances_policy ? [] : [1]

    content {
      id      = local.launch_template_id
      version = local.launch_template_version
    }
  }

  # Use `traffic_source_identifier`/`traffic_source_type` instead
  # load_balancers    = var.load_balancers
  max_instance_lifetime = var.max_instance_lifetime
  max_size              = var.max_size
  metrics_granularity   = var.metrics_granularity
  min_elb_capacity      = var.min_elb_capacity
  min_size              = var.min_size

  dynamic "mixed_instances_policy" {
    for_each = var.use_mixed_instances_policy ? [var.mixed_instances_policy] : []

    content {
      dynamic "instances_distribution" {
        for_each = mixed_instances_policy.value.instances_distribution != null ? [mixed_instances_policy.value.instances_distribution] : []

        content {
          on_demand_allocation_strategy            = instances_distribution.value.on_demand_allocation_strategy
          on_demand_base_capacity                  = instances_distribution.value.on_demand_base_capacity
          on_demand_percentage_above_base_capacity = instances_distribution.value.on_demand_percentage_above_base_capacity
          spot_allocation_strategy                 = instances_distribution.value.spot_allocation_strategy
          spot_instance_pools                      = instances_distribution.value.spot_instance_pools
          spot_max_price                           = instances_distribution.value.spot_max_price
        }
      }

      dynamic "launch_template" {
        for_each = [mixed_instances_policy.value.launch_template]

        content {
          launch_template_specification {
            launch_template_id = local.launch_template_id
            version            = local.launch_template_version
          }

          dynamic "override" {
            for_each = launch_template.value.override != null ? launch_template.value.override : []

            content {
              dynamic "instance_requirements" {
                for_each = override.value.instance_requirements != null ? [override.value.instance_requirements] : []

                content {
                  dynamic "accelerator_count" {
                    for_each = instance_requirements.value.accelerator_count != null ? [instance_requirements.value.accelerator_count] : []

                    content {
                      max = accelerator_count.value.max
                      min = accelerator_count.value.min
                    }
                  }

                  accelerator_manufacturers = instance_requirements.value.accelerator_manufacturers
                  accelerator_names         = instance_requirements.value.accelerator_names

                  dynamic "accelerator_total_memory_mib" {
                    for_each = instance_requirements.value.accelerator_total_memory_mib != null ? [instance_requirements.value.accelerator_total_memory_mib] : []

                    content {
                      max = accelerator_total_memory_mib.value.max
                      min = accelerator_total_memory_mib.value.min
                    }
                  }

                  accelerator_types      = instance_requirements.value.accelerator_types
                  allowed_instance_types = instance_requirements.value.allowed_instance_types
                  bare_metal             = instance_requirements.value.bare_metal

                  dynamic "baseline_ebs_bandwidth_mbps" {
                    for_each = instance_requirements.value.baseline_ebs_bandwidth_mbps != null ? [instance_requirements.value.baseline_ebs_bandwidth_mbps] : []

                    content {
                      max = baseline_ebs_bandwidth_mbps.value.max
                      min = baseline_ebs_bandwidth_mbps.value.min
                    }
                  }

                  burstable_performance                                   = instance_requirements.value.burstable_performance
                  cpu_manufacturers                                       = instance_requirements.value.cpu_manufacturers
                  excluded_instance_types                                 = instance_requirements.value.excluded_instance_types
                  instance_generations                                    = instance_requirements.value.instance_generations
                  local_storage                                           = instance_requirements.value.local_storage
                  local_storage_types                                     = instance_requirements.value.local_storage_types
                  max_spot_price_as_percentage_of_optimal_on_demand_price = instance_requirements.value.max_spot_price_as_percentage_of_optimal_on_demand_price

                  dynamic "memory_gib_per_vcpu" {
                    for_each = instance_requirements.value.memory_gib_per_vcpu != null ? [instance_requirements.value.memory_gib_per_vcpu] : []

                    content {
                      max = memory_gib_per_vcpu.value.max
                      min = memory_gib_per_vcpu.value.min
                    }
                  }

                  dynamic "memory_mib" {
                    for_each = instance_requirements.value.memory_mib != null ? [instance_requirements.value.memory_mib] : []

                    content {
                      max = memory_mib.value.max
                      min = memory_mib.value.min
                    }
                  }

                  dynamic "network_bandwidth_gbps" {
                    for_each = instance_requirements.value.network_bandwidth_gbps != null ? [instance_requirements.value.network_bandwidth_gbps] : []

                    content {
                      max = network_bandwidth_gbps.value.max
                      min = network_bandwidth_gbps.value.min
                    }
                  }

                  dynamic "network_interface_count" {
                    for_each = instance_requirements.value.network_interface_count != null ? [instance_requirements.value.network_interface_count] : []

                    content {
                      max = network_interface_count.value.max
                      min = network_interface_count.value.min
                    }
                  }

                  on_demand_max_price_percentage_over_lowest_price = instance_requirements.value.on_demand_max_price_percentage_over_lowest_price
                  require_hibernate_support                        = instance_requirements.value.require_hibernate_support
                  spot_max_price_percentage_over_lowest_price      = instance_requirements.value.spot_max_price_percentage_over_lowest_price

                  dynamic "total_local_storage_gb" {
                    for_each = instance_requirements.value.total_local_storage_gb != null ? [instance_requirements.value.total_local_storage_gb] : []

                    content {
                      max = total_local_storage_gb.value.max
                      min = total_local_storage_gb.value.min
                    }
                  }

                  dynamic "vcpu_count" {
                    for_each = instance_requirements.value.vcpu_count != null ? [instance_requirements.value.vcpu_count] : []

                    content {
                      max = vcpu_count.value.max
                      min = vcpu_count.value.min
                    }
                  }
                }
              }

              instance_type = override.value.instance_type

              dynamic "launch_template_specification" {
                for_each = override.value.launch_template_specification != null ? [override.value.launch_template_specification] : []

                content {
                  launch_template_id   = launch_template_specification.value.launch_template_id
                  launch_template_name = launch_template_specification.value.launch_template_name
                  version              = launch_template_specification.value.version
                }
              }

              weighted_capacity = override.value.weighted_capacity
            }
          }
        }
      }
    }
  }

  name                    = var.use_name_prefix ? null : var.name
  name_prefix             = var.use_name_prefix ? "${var.name}-" : null
  placement_group         = var.placement_group
  protect_from_scale_in   = var.protect_from_scale_in
  service_linked_role_arn = var.service_linked_role_arn
  suspended_processes     = var.suspended_processes

  dynamic "tag" {
    for_each = local.autoscaling_group_tags

    content {
      key                 = tag.key
      propagate_at_launch = contains(var.autoscaling_group_tags_not_propagate_at_launch, tag.key) ? false : true
      value               = tag.value
    }
  }

  # Use `traffic_source_identifier`/`traffic_source_type` instead
  # target_group_arns = var.target_group_arns

  termination_policies      = var.termination_policies
  vpc_zone_identifier       = var.vpc_zone_identifier
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  wait_for_elb_capacity     = var.wait_for_elb_capacity

  dynamic "warm_pool" {
    for_each = var.warm_pool != null ? [var.warm_pool] : []

    content {
      dynamic "instance_reuse_policy" {
        for_each = warm_pool.value.instance_reuse_policy != null ? [warm_pool.value.instance_reuse_policy] : []

        content {
          reuse_on_scale_in = instance_reuse_policy.value.reuse_on_scale_in
        }
      }

      max_group_prepared_capacity = warm_pool.value.max_group_prepared_capacity
      min_size                    = warm_pool.value.min_size
      pool_state                  = warm_pool.value.pool_state
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      delete = var.timeouts.delete
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      load_balancers,
      target_group_arns,
    ]
  }
}

################################################################################
# Autoscaling group - ignore desired capacity
################################################################################

resource "aws_autoscaling_group" "idc" {
  count = local.create && var.ignore_desired_capacity_changes ? 1 : 0

  region = var.region

  availability_zones = var.availability_zones

  dynamic "availability_zone_distribution" {
    for_each = var.availability_zone_distribution != null ? [var.availability_zone_distribution] : []

    content {
      capacity_distribution_strategy = availability_zone_distribution.value.capacity_distribution_strategy
    }
  }

  capacity_rebalance = var.capacity_rebalance
  # capacity_reservation_specification set on launch template
  context                          = var.context
  default_cooldown                 = var.default_cooldown
  default_instance_warmup          = var.default_instance_warmup
  desired_capacity                 = var.desired_capacity
  desired_capacity_type            = var.desired_capacity_type
  enabled_metrics                  = var.enabled_metrics
  force_delete                     = var.force_delete
  force_delete_warm_pool           = var.force_delete_warm_pool
  health_check_grace_period        = var.health_check_grace_period
  health_check_type                = var.health_check_type
  ignore_failed_scaling_activities = var.ignore_failed_scaling_activities

  dynamic "initial_lifecycle_hook" {
    for_each = var.initial_lifecycle_hooks != null ? var.initial_lifecycle_hooks : []

    content {
      default_result          = initial_lifecycle_hook.value.default_result
      heartbeat_timeout       = initial_lifecycle_hook.value.heartbeat_timeout
      lifecycle_transition    = initial_lifecycle_hook.value.lifecycle_transition
      name                    = initial_lifecycle_hook.value.name
      notification_metadata   = initial_lifecycle_hook.value.notification_metadata
      notification_target_arn = initial_lifecycle_hook.value.notification_target_arn
      role_arn                = initial_lifecycle_hook.value.role_arn
    }
  }

  dynamic "instance_maintenance_policy" {
    for_each = var.instance_maintenance_policy != null ? [var.instance_maintenance_policy] : []

    content {
      min_healthy_percentage = instance_maintenance_policy.value.min_healthy_percentage
      max_healthy_percentage = instance_maintenance_policy.value.max_healthy_percentage
    }
  }

  dynamic "instance_refresh" {
    for_each = var.instance_refresh != null ? [var.instance_refresh] : []

    content {
      dynamic "preferences" {
        for_each = instance_refresh.value.preferences != null ? [instance_refresh.value.preferences] : []

        content {
          dynamic "alarm_specification" {
            for_each = preferences.value.alarm_specification != null ? [preferences.value.alarm_specification] : []

            content {
              alarms = alarm_specification.value.alarms
            }
          }

          auto_rollback                = preferences.value.auto_rollback
          checkpoint_delay             = preferences.value.checkpoint_delay
          checkpoint_percentages       = preferences.value.checkpoint_percentages
          instance_warmup              = preferences.value.instance_warmup
          max_healthy_percentage       = preferences.value.max_healthy_percentage
          min_healthy_percentage       = preferences.value.min_healthy_percentage
          scale_in_protected_instances = preferences.value.scale_in_protected_instances
          skip_matching                = preferences.value.skip_matching
          standby_instances            = preferences.value.standby_instances
        }
      }

      strategy = instance_refresh.value.strategy
      triggers = instance_refresh.value.triggers
    }
  }

  dynamic "launch_template" {
    for_each = var.use_mixed_instances_policy ? [] : [1]

    content {
      id      = local.launch_template_id
      version = local.launch_template_version
    }
  }

  # Use `traffic_source_identifier`/`traffic_source_type` instead
  # load_balancers    = var.load_balancers
  max_instance_lifetime = var.max_instance_lifetime
  max_size              = var.max_size
  metrics_granularity   = var.metrics_granularity
  min_elb_capacity      = var.min_elb_capacity
  min_size              = var.min_size

  dynamic "mixed_instances_policy" {
    for_each = var.use_mixed_instances_policy ? [var.mixed_instances_policy] : []

    content {
      dynamic "instances_distribution" {
        for_each = mixed_instances_policy.value.instances_distribution != null ? [mixed_instances_policy.value.instances_distribution] : []

        content {
          on_demand_allocation_strategy            = instances_distribution.value.on_demand_allocation_strategy
          on_demand_base_capacity                  = instances_distribution.value.on_demand_base_capacity
          on_demand_percentage_above_base_capacity = instances_distribution.value.on_demand_percentage_above_base_capacity
          spot_allocation_strategy                 = instances_distribution.value.spot_allocation_strategy
          spot_instance_pools                      = instances_distribution.value.spot_instance_pools
          spot_max_price                           = instances_distribution.value.spot_max_price
        }
      }

      dynamic "launch_template" {
        for_each = [mixed_instances_policy.value.launch_template]

        content {
          launch_template_specification {
            launch_template_id = local.launch_template_id
            version            = local.launch_template_version
          }

          dynamic "override" {
            for_each = launch_template.value.override != null ? launch_template.value.override : []

            content {
              dynamic "instance_requirements" {
                for_each = override.value.instance_requirements != null ? [override.value.instance_requirements] : []

                content {
                  dynamic "accelerator_count" {
                    for_each = instance_requirements.value.accelerator_count != null ? [instance_requirements.value.accelerator_count] : []

                    content {
                      max = accelerator_count.value.max
                      min = accelerator_count.value.min
                    }
                  }

                  accelerator_manufacturers = instance_requirements.value.accelerator_manufacturers
                  accelerator_names         = instance_requirements.value.accelerator_names

                  dynamic "accelerator_total_memory_mib" {
                    for_each = instance_requirements.value.accelerator_total_memory_mib != null ? [instance_requirements.value.accelerator_total_memory_mib] : []

                    content {
                      max = accelerator_total_memory_mib.value.max
                      min = accelerator_total_memory_mib.value.min
                    }
                  }

                  accelerator_types      = instance_requirements.value.accelerator_types
                  allowed_instance_types = instance_requirements.value.allowed_instance_types
                  bare_metal             = instance_requirements.value.bare_metal

                  dynamic "baseline_ebs_bandwidth_mbps" {
                    for_each = instance_requirements.value.baseline_ebs_bandwidth_mbps != null ? [instance_requirements.value.baseline_ebs_bandwidth_mbps] : []

                    content {
                      max = baseline_ebs_bandwidth_mbps.value.max
                      min = baseline_ebs_bandwidth_mbps.value.min
                    }
                  }

                  burstable_performance                                   = instance_requirements.value.burstable_performance
                  cpu_manufacturers                                       = instance_requirements.value.cpu_manufacturers
                  excluded_instance_types                                 = instance_requirements.value.excluded_instance_types
                  instance_generations                                    = instance_requirements.value.instance_generations
                  local_storage                                           = instance_requirements.value.local_storage
                  local_storage_types                                     = instance_requirements.value.local_storage_types
                  max_spot_price_as_percentage_of_optimal_on_demand_price = instance_requirements.value.max_spot_price_as_percentage_of_optimal_on_demand_price

                  dynamic "memory_gib_per_vcpu" {
                    for_each = instance_requirements.value.memory_gib_per_vcpu != null ? [instance_requirements.value.memory_gib_per_vcpu] : []

                    content {
                      max = memory_gib_per_vcpu.value.max
                      min = memory_gib_per_vcpu.value.min
                    }
                  }

                  dynamic "memory_mib" {
                    for_each = instance_requirements.value.memory_mib != null ? [instance_requirements.value.memory_mib] : []

                    content {
                      max = memory_mib.value.max
                      min = memory_mib.value.min
                    }
                  }

                  dynamic "network_bandwidth_gbps" {
                    for_each = instance_requirements.value.network_bandwidth_gbps != null ? [instance_requirements.value.network_bandwidth_gbps] : []

                    content {
                      max = network_bandwidth_gbps.value.max
                      min = network_bandwidth_gbps.value.min
                    }
                  }

                  dynamic "network_interface_count" {
                    for_each = instance_requirements.value.network_interface_count != null ? [instance_requirements.value.network_interface_count] : []

                    content {
                      max = network_interface_count.value.max
                      min = network_interface_count.value.min
                    }
                  }

                  on_demand_max_price_percentage_over_lowest_price = instance_requirements.value.on_demand_max_price_percentage_over_lowest_price
                  require_hibernate_support                        = instance_requirements.value.require_hibernate_support
                  spot_max_price_percentage_over_lowest_price      = instance_requirements.value.spot_max_price_percentage_over_lowest_price

                  dynamic "total_local_storage_gb" {
                    for_each = instance_requirements.value.total_local_storage_gb != null ? [instance_requirements.value.total_local_storage_gb] : []

                    content {
                      max = total_local_storage_gb.value.max
                      min = total_local_storage_gb.value.min
                    }
                  }

                  dynamic "vcpu_count" {
                    for_each = instance_requirements.value.vcpu_count != null ? [instance_requirements.value.vcpu_count] : []

                    content {
                      max = vcpu_count.value.max
                      min = vcpu_count.value.min
                    }
                  }
                }
              }

              instance_type = override.value.instance_type

              dynamic "launch_template_specification" {
                for_each = override.value.launch_template_specification != null ? [override.value.launch_template_specification] : []

                content {
                  launch_template_id   = launch_template_specification.value.launch_template_id
                  launch_template_name = launch_template_specification.value.launch_template_name
                  version              = launch_template_specification.value.version
                }
              }

              weighted_capacity = override.value.weighted_capacity
            }
          }
        }
      }
    }
  }

  name                    = var.use_name_prefix ? null : var.name
  name_prefix             = var.use_name_prefix ? "${var.name}-" : null
  placement_group         = var.placement_group
  protect_from_scale_in   = var.protect_from_scale_in
  service_linked_role_arn = var.service_linked_role_arn
  suspended_processes     = var.suspended_processes

  dynamic "tag" {
    for_each = local.autoscaling_group_tags

    content {
      key                 = tag.key
      propagate_at_launch = contains(var.autoscaling_group_tags_not_propagate_at_launch, tag.key) ? false : true
      value               = tag.value
    }
  }

  # Use `traffic_source_identifier`/`traffic_source_type` instead
  # target_group_arns = var.target_group_arns

  termination_policies      = var.termination_policies
  vpc_zone_identifier       = var.vpc_zone_identifier
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  wait_for_elb_capacity     = var.wait_for_elb_capacity

  dynamic "warm_pool" {
    for_each = var.warm_pool != null ? [var.warm_pool] : []

    content {
      dynamic "instance_reuse_policy" {
        for_each = warm_pool.value.instance_reuse_policy != null ? [warm_pool.value.instance_reuse_policy] : []

        content {
          reuse_on_scale_in = instance_reuse_policy.value.reuse_on_scale_in
        }
      }

      max_group_prepared_capacity = warm_pool.value.max_group_prepared_capacity
      min_size                    = warm_pool.value.min_size
      pool_state                  = warm_pool.value.pool_state
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      delete = var.timeouts.delete
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      desired_capacity,
      load_balancers,
      target_group_arns,
    ]
  }
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

  region = var.region

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings != null ? var.block_device_mappings : []

    content {
      device_name = block_device_mappings.value.device_name

      dynamic "ebs" {
        for_each = block_device_mappings.value.ebs != null ? [block_device_mappings.value.ebs] : []

        content {
          delete_on_termination      = ebs.value.delete_on_termination
          encrypted                  = ebs.value.encrypted
          iops                       = ebs.value.iops
          kms_key_id                 = ebs.value.kms_key_id
          snapshot_id                = ebs.value.snapshot_id
          throughput                 = ebs.value.throughput
          volume_initialization_rate = ebs.value.volume_initialization_rate
          volume_size                = ebs.value.volume_size
          volume_type                = ebs.value.volume_type
        }
      }

      no_device    = block_device_mappings.value.no_device
      virtual_name = block_device_mappings.value.virtual_name
    }
  }

  dynamic "capacity_reservation_specification" {
    for_each = var.capacity_reservation_specification != null ? [var.capacity_reservation_specification] : []

    content {
      capacity_reservation_preference = capacity_reservation_specification.value.capacity_reservation_preference

      dynamic "capacity_reservation_target" {
        for_each = capacity_reservation_specification.value.capacity_reservation_target != null ? [capacity_reservation_specification.value.capacity_reservation_target] : []
        content {
          capacity_reservation_id                 = capacity_reservation_target.value.capacity_reservation_id
          capacity_reservation_resource_group_arn = capacity_reservation_target.value.capacity_reservation_resource_group_arn
        }
      }
    }
  }

  dynamic "cpu_options" {
    for_each = var.cpu_options != null ? [var.cpu_options] : []

    content {
      amd_sev_snp           = cpu_options.value.amd_sev_snp
      core_count            = cpu_options.value.core_count
      nested_virtualization = cpu_options.value.nested_virtualization
      threads_per_core      = cpu_options.value.threads_per_core
    }
  }

  dynamic "credit_specification" {
    for_each = var.credit_specification != null ? [var.credit_specification] : []

    content {
      cpu_credits = credit_specification.value.cpu_credits
    }
  }

  default_version         = var.default_version
  description             = var.launch_template_description
  disable_api_stop        = var.disable_api_stop
  disable_api_termination = var.disable_api_termination
  ebs_optimized           = var.ebs_optimized

  dynamic "enclave_options" {
    for_each = var.enclave_options != null ? [var.enclave_options] : []

    content {
      enabled = enclave_options.value.enabled
    }
  }

  dynamic "hibernation_options" {
    for_each = var.hibernation_options != null ? [var.hibernation_options] : []

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

  image_id                             = var.image_id
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior

  dynamic "instance_market_options" {
    for_each = var.instance_market_options != null ? [var.instance_market_options] : []

    content {
      market_type = instance_market_options.value.market_type

      dynamic "spot_options" {
        for_each = instance_market_options.value.spot_options != null ? [instance_market_options.value.spot_options] : []

        content {
          block_duration_minutes         = spot_options.value.block_duration_minutes
          instance_interruption_behavior = spot_options.value.instance_interruption_behavior
          max_price                      = spot_options.value.max_price
          spot_instance_type             = spot_options.value.spot_instance_type
          valid_until                    = spot_options.value.valid_until
        }
      }
    }
  }

  dynamic "instance_requirements" {
    for_each = var.instance_requirements != null ? [var.instance_requirements] : []

    content {
      dynamic "accelerator_count" {
        for_each = instance_requirements.value.accelerator_count != null ? [instance_requirements.value.accelerator_count] : []

        content {
          max = accelerator_count.value.max
          min = accelerator_count.value.min
        }
      }

      accelerator_manufacturers = instance_requirements.value.accelerator_manufacturers
      accelerator_names         = instance_requirements.value.accelerator_names

      dynamic "accelerator_total_memory_mib" {
        for_each = instance_requirements.value.accelerator_total_memory_mib != null ? [instance_requirements.value.accelerator_total_memory_mib] : []

        content {
          max = accelerator_total_memory_mib.value.max
          min = accelerator_total_memory_mib.value.min
        }
      }

      accelerator_types      = instance_requirements.value.accelerator_types
      allowed_instance_types = instance_requirements.value.allowed_instance_types
      bare_metal             = instance_requirements.value.bare_metal

      dynamic "baseline_ebs_bandwidth_mbps" {
        for_each = instance_requirements.value.baseline_ebs_bandwidth_mbps != null ? [instance_requirements.value.baseline_ebs_bandwidth_mbps] : []

        content {
          max = baseline_ebs_bandwidth_mbps.value.max
          min = baseline_ebs_bandwidth_mbps.value.min
        }
      }

      burstable_performance                                   = instance_requirements.value.burstable_performance
      cpu_manufacturers                                       = instance_requirements.value.cpu_manufacturers
      excluded_instance_types                                 = instance_requirements.value.excluded_instance_types
      instance_generations                                    = instance_requirements.value.instance_generations
      local_storage                                           = instance_requirements.value.local_storage
      local_storage_types                                     = instance_requirements.value.local_storage_types
      max_spot_price_as_percentage_of_optimal_on_demand_price = instance_requirements.value.max_spot_price_as_percentage_of_optimal_on_demand_price

      dynamic "memory_gib_per_vcpu" {
        for_each = instance_requirements.value.memory_gib_per_vcpu != null ? [instance_requirements.value.memory_gib_per_vcpu] : []

        content {
          max = memory_gib_per_vcpu.value.max
          min = memory_gib_per_vcpu.value.min
        }
      }

      dynamic "memory_mib" {
        for_each = instance_requirements.value.memory_mib != null ? [instance_requirements.value.memory_mib] : []

        content {
          max = memory_mib.value.max
          min = memory_mib.value.min
        }
      }

      dynamic "network_interface_count" {
        for_each = instance_requirements.value.network_interface_count != null ? [instance_requirements.value.network_interface_count] : []

        content {
          max = network_interface_count.value.max
          min = network_interface_count.value.min
        }
      }

      on_demand_max_price_percentage_over_lowest_price = instance_requirements.value.on_demand_max_price_percentage_over_lowest_price
      require_hibernate_support                        = instance_requirements.value.require_hibernate_support
      spot_max_price_percentage_over_lowest_price      = instance_requirements.value.spot_max_price_percentage_over_lowest_price

      dynamic "total_local_storage_gb" {
        for_each = instance_requirements.value.total_local_storage_gb != null ? [instance_requirements.value.total_local_storage_gb] : []

        content {
          max = total_local_storage_gb.value.max
          min = total_local_storage_gb.value.min
        }
      }

      dynamic "vcpu_count" {
        for_each = instance_requirements.value.vcpu_count != null ? [instance_requirements.value.vcpu_count] : []

        content {
          max = vcpu_count.value.max
          min = vcpu_count.value.min
        }
      }
    }
  }

  instance_type = var.instance_type
  kernel_id     = var.kernel_id
  key_name      = var.key_name

  dynamic "license_specification" {
    for_each = var.license_specifications != null ? var.license_specifications : []

    content {
      license_configuration_arn = license_specification.value.license_configuration_arn
    }
  }

  dynamic "maintenance_options" {
    for_each = var.maintenance_options != null ? [var.maintenance_options] : []

    content {
      auto_recovery = maintenance_options.value.auto_recovery
    }
  }

  dynamic "metadata_options" {
    for_each = var.metadata_options != null ? [var.metadata_options] : []

    content {
      http_endpoint               = metadata_options.value.http_endpoint
      http_protocol_ipv6          = metadata_options.value.http_protocol_ipv6
      http_put_response_hop_limit = metadata_options.value.http_put_response_hop_limit
      http_tokens                 = metadata_options.value.http_tokens
      instance_metadata_tags      = metadata_options.value.instance_metadata_tags
    }
  }

  dynamic "monitoring" {
    for_each = var.enable_monitoring ? [1] : []

    content {
      enabled = var.enable_monitoring
    }
  }

  name        = var.launch_template_use_name_prefix ? null : local.launch_template_name
  name_prefix = var.launch_template_use_name_prefix ? "${local.launch_template_name}-" : null

  dynamic "network_interfaces" {
    for_each = var.network_interfaces != null ? var.network_interfaces : []

    content {
      associate_carrier_ip_address = network_interfaces.value.associate_carrier_ip_address
      associate_public_ip_address  = network_interfaces.value.associate_public_ip_address

      dynamic "connection_tracking_specification" {
        for_each = network_interfaces.value.connection_tracking_specification != null ? [network_interfaces.value.connection_tracking_specification] : []

        content {
          tcp_established_timeout = connection_tracking_specification.value.tcp_established_timeout
          udp_stream_timeout      = connection_tracking_specification.value.udp_stream_timeout
          udp_timeout             = connection_tracking_specification.value.udp_timeout
        }
      }

      delete_on_termination = network_interfaces.value.delete_on_termination
      description           = network_interfaces.value.description
      device_index          = network_interfaces.value.device_index

      dynamic "ena_srd_specification" {
        for_each = network_interfaces.value.ena_srd_specification != null ? [network_interfaces.value.ena_srd_specification] : []

        content {
          ena_srd_enabled = ena_srd_specification.value.ena_srd_enabled

          dynamic "ena_srd_udp_specification" {
            for_each = ena_srd_specification.value.ena_srd_udp_specification != null ? [ena_srd_specification.value.ena_srd_udp_specification] : []

            content {
              ena_srd_udp_enabled = ena_srd_udp_specification.value.ena_srd_udp_enabled
            }
          }
        }
      }

      interface_type       = network_interfaces.value.interface_type
      ipv4_address_count   = network_interfaces.value.ipv4_address_count
      ipv4_addresses       = network_interfaces.value.ipv4_addresses
      ipv4_prefix_count    = network_interfaces.value.ipv4_prefix_count
      ipv4_prefixes        = network_interfaces.value.ipv4_prefixes
      ipv6_address_count   = network_interfaces.value.ipv6_address_count
      ipv6_addresses       = network_interfaces.value.ipv6_addresses
      ipv6_prefix_count    = network_interfaces.value.ipv6_prefix_count
      ipv6_prefixes        = network_interfaces.value.ipv6_prefixes
      network_card_index   = network_interfaces.value.network_card_index
      network_interface_id = network_interfaces.value.network_interface_id
      primary_ipv6         = network_interfaces.value.primary_ipv6
      private_ip_address   = network_interfaces.value.private_ip_address
      # Ref: https://github.com/hashicorp/terraform-provider-aws/issues/4570
      security_groups = compact(concat(network_interfaces.value.security_groups, var.security_groups))
      subnet_id       = network_interfaces.value.subnet_id
    }
  }

  dynamic "placement" {
    for_each = var.placement != null ? [var.placement] : []

    content {
      affinity                = placement.value.affinity
      availability_zone       = placement.value.availability_zone
      group_id                = placement.value.group_id
      group_name              = placement.value.group_name
      host_id                 = placement.value.host_id
      host_resource_group_arn = placement.value.host_resource_group_arn
      partition_number        = placement.value.partition_number
      spread_domain           = placement.value.spread_domain
      tenancy                 = placement.value.tenancy
    }
  }

  dynamic "network_performance_options" {
    for_each = var.network_performance_options != null ? [var.network_performance_options] : []

    content {
      bandwidth_weighting = network_performance_options.value.bandwidth_weighting
    }
  }

  dynamic "private_dns_name_options" {
    for_each = var.private_dns_name_options != null ? [var.private_dns_name_options] : []

    content {
      enable_resource_name_dns_aaaa_record = private_dns_name_options.value.enable_resource_name_dns_aaaa_record
      enable_resource_name_dns_a_record    = private_dns_name_options.value.enable_resource_name_dns_a_record
      hostname_type                        = private_dns_name_options.value.hostname_type
    }
  }

  ram_disk_id = var.ram_disk_id

  dynamic "secondary_interfaces" {
    for_each = var.secondary_interfaces != null ? var.secondary_interfaces : []

    content {
      delete_on_termination    = secondary_interfaces.value.delete_on_termination
      device_index             = secondary_interfaces.value.device_index
      interface_type           = secondary_interfaces.value.interface_type
      network_card_index       = secondary_interfaces.value.network_card_index
      private_ip_address_count = secondary_interfaces.value.private_ip_address_count
      private_ip_addresses     = secondary_interfaces.value.private_ip_addresses
      secondary_subnet_id      = secondary_interfaces.value.secondary_subnet_id
    }
  }

  dynamic "tag_specifications" {
    for_each = var.tag_specifications != null ? var.tag_specifications : []

    content {
      resource_type = tag_specifications.value.resource_type
      tags          = merge(var.tags, tag_specifications.value.tags)
    }
  }

  tags = merge(
    var.tags,
    var.launch_template_tags,
  )

  update_default_version = var.update_default_version
  user_data              = var.user_data
  # Ref: https://github.com/hashicorp/terraform-provider-aws/issues/4570
  vpc_security_group_ids = var.network_interfaces != null ? [] : var.security_groups

  lifecycle {
    create_before_destroy = true
  }
}

################################################################################
# Autoscaling group traffic source attachment
################################################################################

resource "aws_autoscaling_traffic_source_attachment" "this" {
  for_each = local.create && var.traffic_source_attachments != null ? var.traffic_source_attachments : {}

  region = var.region

  autoscaling_group_name = try(aws_autoscaling_group.this[0].name, aws_autoscaling_group.idc[0].name)

  traffic_source {
    identifier = each.value.traffic_source_identifier
    type       = try(each.value.traffic_source_type, "elbv2")
  }
}

################################################################################
# Autoscaling group schedule
################################################################################

resource "aws_autoscaling_schedule" "this" {
  for_each = local.create && var.schedules != null ? var.schedules : {}

  region = var.region

  autoscaling_group_name = try(aws_autoscaling_group.this[0].name, aws_autoscaling_group.idc[0].name)
  desired_capacity       = each.value.desired_capacity
  end_time               = each.value.end_time
  max_size               = each.value.max_size
  min_size               = each.value.min_size
  recurrence             = each.value.recurrence
  scheduled_action_name  = each.key
  start_time             = each.value.start_time
  time_zone              = each.value.time_zone
}

################################################################################
# Autoscaling Policy
################################################################################

resource "aws_autoscaling_policy" "this" {
  for_each = local.create && var.scaling_policies != null ? var.scaling_policies : {}

  region = var.region

  adjustment_type           = each.value.adjustment_type
  autoscaling_group_name    = try(aws_autoscaling_group.this[0].name, aws_autoscaling_group.idc[0].name)
  cooldown                  = each.value.cooldown
  enabled                   = each.value.enabled
  estimated_instance_warmup = each.value.estimated_instance_warmup
  metric_aggregation_type   = each.value.metric_aggregation_type
  min_adjustment_magnitude  = each.value.min_adjustment_magnitude
  name                      = try(coalesce(each.value.name, each.key), "")
  policy_type               = each.value.policy_type

  dynamic "predictive_scaling_configuration" {
    for_each = each.value.predictive_scaling_configuration != null ? [each.value.predictive_scaling_configuration] : []

    content {
      max_capacity_breach_behavior = predictive_scaling_configuration.value.max_capacity_breach_behavior
      max_capacity_buffer          = predictive_scaling_configuration.value.max_capacity_buffer

      dynamic "metric_specification" {
        for_each = predictive_scaling_configuration.value.metric_specification != null ? [predictive_scaling_configuration.value.metric_specification] : []

        content {
          dynamic "customized_capacity_metric_specification" {
            for_each = metric_specification.value.customized_capacity_metric_specification != null ? [metric_specification.value.customized_capacity_metric_specification] : []

            content {
              dynamic "metric_data_queries" {
                for_each = customized_capacity_metric_specification.value.metric_data_queries != null ? customized_capacity_metric_specification.value.metric_data_queries : []

                content {
                  expression = metric_data_queries.value.expression
                  id         = metric_data_queries.value.id
                  label      = metric_data_queries.value.label

                  dynamic "metric_stat" {
                    for_each = metric_data_queries.value.metric_stat != null ? [metric_data_queries.value.metric_stat] : []

                    content {
                      dynamic "metric" {
                        for_each = metric_stat.value.metric != null ? [metric_stat.value.metric] : []

                        content {
                          dynamic "dimensions" {
                            for_each = metric.value.dimensions != null ? metric.value.dimensions : []

                            content {
                              name  = dimensions.value.name
                              value = dimensions.value.value
                            }
                          }

                          metric_name = metric.value.metric_name
                          namespace   = metric.value.namespace
                        }
                      }

                      stat = metric_stat.value.stat
                      unit = metric_stat.value.unit
                    }
                  }

                  return_data = metric_data_queries.value.return_data
                }
              }
            }
          }

          dynamic "customized_load_metric_specification" {
            for_each = metric_specification.value.customized_load_metric_specification != null ? [metric_specification.value.customized_load_metric_specification] : []

            content {
              dynamic "metric_data_queries" {
                for_each = customized_load_metric_specification.value.metric_data_queries != null ? customized_load_metric_specification.value.metric_data_queries : []

                content {
                  expression = metric_data_queries.value.expression
                  id         = metric_data_queries.value.id
                  label      = metric_data_queries.value.label

                  dynamic "metric_stat" {
                    for_each = metric_data_queries.value.metric_stat != null ? [metric_data_queries.value.metric_stat] : []

                    content {
                      dynamic "metric" {
                        for_each = metric_stat.value.metric != null ? [metric_stat.value.metric] : []

                        content {
                          dynamic "dimensions" {
                            for_each = metric.value.dimensions != null ? metric.value.dimensions : []

                            content {
                              name  = dimensions.value.name
                              value = dimensions.value.value
                            }
                          }

                          metric_name = metric.value.metric_name
                          namespace   = metric.value.namespace
                        }
                      }

                      stat = metric_stat.value.stat
                      unit = metric_stat.value.unit
                    }
                  }

                  return_data = metric_data_queries.value.return_data
                }
              }
            }
          }

          dynamic "customized_scaling_metric_specification" {
            for_each = metric_specification.value.customized_scaling_metric_specification != null ? [metric_specification.value.customized_scaling_metric_specification] : []

            content {
              dynamic "metric_data_queries" {
                for_each = customized_scaling_metric_specification.value.metric_data_queries != null ? customized_scaling_metric_specification.value.metric_data_queries : []

                content {
                  expression = metric_data_queries.value.expression
                  id         = metric_data_queries.value.id
                  label      = metric_data_queries.value.label

                  dynamic "metric_stat" {
                    for_each = metric_data_queries.value.metric_stat != null ? [metric_data_queries.value.metric_stat] : []

                    content {
                      dynamic "metric" {
                        for_each = metric_stat.value.metric != null ? [metric_stat.value.metric] : []

                        content {
                          dynamic "dimensions" {
                            for_each = metric.value.dimensions != null ? metric.value.dimensions : []

                            content {
                              name  = dimensions.value.name
                              value = dimensions.value.value
                            }
                          }

                          metric_name = metric.value.metric_name
                          namespace   = metric.value.namespace
                        }
                      }

                      stat = metric_stat.value.stat
                      unit = metric_stat.value.unit
                    }
                  }

                  return_data = metric_data_queries.value.return_data
                }
              }
            }
          }

          dynamic "predefined_load_metric_specification" {
            for_each = metric_specification.value.predefined_load_metric_specification != null ? [metric_specification.value.predefined_load_metric_specification] : []

            content {
              predefined_metric_type = predefined_load_metric_specification.value.predefined_metric_type
              resource_label         = predefined_load_metric_specification.value.resource_label
            }
          }

          dynamic "predefined_metric_pair_specification" {
            for_each = metric_specification.value.predefined_metric_pair_specification != null ? [metric_specification.value.predefined_metric_pair_specification] : []

            content {
              predefined_metric_type = predefined_metric_pair_specification.value.predefined_metric_type
              resource_label         = predefined_metric_pair_specification.value.resource_label
            }
          }

          dynamic "predefined_scaling_metric_specification" {
            for_each = metric_specification.value.predefined_scaling_metric_specification != null ? [metric_specification.value.predefined_scaling_metric_specification] : []

            content {
              predefined_metric_type = predefined_scaling_metric_specification.value.predefined_metric_type
              resource_label         = predefined_scaling_metric_specification.value.resource_label
            }
          }

          target_value = metric_specification.value.target_value
        }
      }

      mode                   = predictive_scaling_configuration.value.mode
      scheduling_buffer_time = predictive_scaling_configuration.value.scheduling_buffer_time
    }
  }

  scaling_adjustment = each.value.scaling_adjustment

  dynamic "step_adjustment" {
    for_each = each.value.step_adjustment != null ? each.value.step_adjustment : []

    content {
      metric_interval_lower_bound = step_adjustment.value.metric_interval_lower_bound
      metric_interval_upper_bound = step_adjustment.value.metric_interval_upper_bound
      scaling_adjustment          = step_adjustment.value.scaling_adjustment
    }
  }

  dynamic "target_tracking_configuration" {
    for_each = each.value.target_tracking_configuration != null ? [each.value.target_tracking_configuration] : []

    content {
      dynamic "customized_metric_specification" {
        for_each = target_tracking_configuration.value.customized_metric_specification != null ? [target_tracking_configuration.value.customized_metric_specification] : []

        content {
          dynamic "metric_dimension" {
            for_each = customized_metric_specification.value.metric_dimension != null ? customized_metric_specification.value.metric_dimension : []

            content {
              name  = metric_dimension.value.name
              value = metric_dimension.value.value
            }
          }

          metric_name = customized_metric_specification.value.metric_name

          dynamic "metrics" {
            for_each = customized_metric_specification.value.metrics != null ? customized_metric_specification.value.metrics : []

            content {
              expression = metrics.value.expression
              id         = metrics.value.id
              label      = metrics.value.label

              dynamic "metric_stat" {
                for_each = metrics.value.metric_stat != null ? [metrics.value.metric_stat] : []

                content {
                  dynamic "metric" {
                    for_each = metric_stat.value.metric != null ? [metric_stat.value.metric] : []

                    content {
                      dynamic "dimensions" {
                        for_each = metric.value.dimensions != null ? metric.value.dimensions : []

                        content {
                          name  = dimensions.value.name
                          value = dimensions.value.value
                        }
                      }

                      metric_name = metric.value.metric_name
                      namespace   = metric.value.namespace
                    }
                  }

                  period = metric_stat.value.period
                  stat   = metric_stat.value.stat
                  unit   = metric_stat.value.unit
                }
              }

              return_data = metrics.value.return_data
            }
          }

          namespace = customized_metric_specification.value.namespace
          period    = customized_metric_specification.value.period
          statistic = customized_metric_specification.value.statistic
          unit      = customized_metric_specification.value.unit
        }
      }

      disable_scale_in = target_tracking_configuration.value.disable_scale_in

      dynamic "predefined_metric_specification" {
        for_each = target_tracking_configuration.value.predefined_metric_specification != null ? [target_tracking_configuration.value.predefined_metric_specification] : []

        content {
          predefined_metric_type = predefined_metric_specification.value.predefined_metric_type
          resource_label         = predefined_metric_specification.value.resource_label
        }
      }

      target_value = target_tracking_configuration.value.target_value
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
