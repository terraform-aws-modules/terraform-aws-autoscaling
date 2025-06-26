variable "create" {
  description = "Determines whether to create autoscaling group or not"
  type        = bool
  default     = true
}

variable "region" {
  description = "Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Autoscaling group
################################################################################

variable "availability_zones" {
  description = "A list of Availability Zones where instances in the Auto Scaling group can be created. Used for launching into the default VPC subnet in each Availability Zone when not using the `vpc_zone_identifier` attribute, or for attaching a network interface when an existing network interface ID is specified in a launch template. Conflicts with `vpc_zone_identifier`"
  type        = list(string)
  default     = null
}

variable "availability_zone_distribution" {
  description = "A map of configuration for capacity distribution across availability zones"
  type = object({
    capacity_distribution_strategy = optional(string)
  })
  default = null
}

variable "capacity_rebalance" {
  description = "Indicates whether capacity rebalance is enabled"
  type        = bool
  default     = null
}

variable "context" {
  description = "Reserved"
  type        = string
  default     = null
}

variable "default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  type        = number
  default     = null
}

variable "default_instance_warmup" {
  description = "Amount of time, in seconds, until a newly launched instance can contribute to the Amazon CloudWatch metrics. This delay lets an instance finish initializing before Amazon EC2 Auto Scaling aggregates instance metrics, resulting in more reliable usage data. Set this value equal to the amount of time that it takes for resource consumption to become stable after an instance reaches the InService state."
  type        = number
  default     = null
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the autoscaling group"
  type        = number
  default     = null
}

variable "desired_capacity_type" {
  description = "The unit of measurement for the value specified for desired_capacity. Supported for attribute-based instance type selection only. Valid values: `units`, `vcpu`, `memory-mib`."
  type        = string
  default     = null
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are `GroupDesiredCapacity`, `GroupInServiceCapacity`, `GroupPendingCapacity`, `GroupMinSize`, `GroupMaxSize`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupStandbyCapacity`, `GroupTerminatingCapacity`, `GroupTerminatingInstances`, `GroupTotalCapacity`, `GroupTotalInstances`"
  type        = list(string)
  default     = []
}

variable "force_delete" {
  description = "Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate. You can force an Auto Scaling Group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  type        = bool
  default     = null
}

variable "force_delete_warm_pool" {
  description = "Allows deleting the Auto Scaling Group without waiting for all instances in the warm pool to terminate"
  type        = bool
  default     = null
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
  default     = null
}

variable "health_check_type" {
  description = "`EC2` or `ELB`. Controls how health checking is done"
  type        = string
  default     = null
}

variable "ignore_failed_scaling_activities" {
  description = "Whether to ignore failed Auto Scaling scaling activities while waiting for capacity. The default is false -- failed scaling activities cause errors to be returned."
  type        = bool
  default     = false
}

variable "ignore_desired_capacity_changes" {
  description = "Determines whether the `desired_capacity` value is ignored after initial apply. See README note for more details"
  type        = bool
  default     = false
}

variable "initial_lifecycle_hooks" {
  description = "One or more Lifecycle Hooks to attach to the Auto Scaling Group before instances are launched. The syntax is exactly the same as the separate `aws_autoscaling_lifecycle_hook` resource, without the `autoscaling_group_name` attribute. Please note that this will only work when creating a new Auto Scaling Group. For all other use-cases, please use `aws_autoscaling_lifecycle_hook` resource"
  type = list(object({
    default_result          = optional(string)
    heartbeat_timeout       = optional(number)
    lifecycle_transition    = string
    name                    = string
    notification_metadata   = optional(string)
    notification_target_arn = optional(string)
    role_arn                = optional(string)
  }))
  default = null
}

variable "instance_maintenance_policy" {
  description = "If this block is configured, add a instance maintenance policy to the specified Auto Scaling group"
  type = object({
    max_healthy_percentage = number
    min_healthy_percentage = number
  })
  default = null
}

variable "instance_refresh" {
  description = "If this block is configured, start an Instance Refresh when this Auto Scaling Group is updated"
  type = object({
    preferences = optional(object({
      alarm_specification = optional(object({
        alarms = optional(list(string))
      }))
      auto_rollback                = optional(bool)
      checkpoint_delay             = optional(number)
      checkpoint_percentages       = optional(list(number))
      instance_warmup              = optional(number)
      max_healthy_percentage       = optional(number)
      min_healthy_percentage       = optional(number)
      scale_in_protected_instances = optional(string)
      skip_matching                = optional(bool)
      standby_instances            = optional(string)
    }))
    strategy = string
    triggers = optional(list(string))
  })
  default = null
}

variable "launch_template_id" {
  description = "ID of an existing launch template to be used (created outside of this module)"
  type        = string
  default     = null
}

variable "launch_template_version" {
  description = "Launch template version. Can be version number, `$Latest`, or `$Default`"
  type        = string
  default     = null
}

variable "max_instance_lifetime" {
  description = "The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 86400 and 31536000 seconds"
  type        = number
  default     = null
}

variable "max_size" {
  description = "The maximum size of the autoscaling group"
  type        = number
  default     = null
}

variable "metrics_granularity" {
  description = "The granularity to associate with the metrics to collect. The only valid value is `1Minute`"
  type        = string
  default     = null
}

variable "min_elb_capacity" {
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  type        = number
  default     = null
}

variable "min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
  default     = null
}

variable "use_mixed_instances_policy" {
  description = "Determines whether to use a mixed instances policy in the autoscaling group or not"
  type        = bool
  default     = false
}

variable "mixed_instances_policy" {
  description = "Configuration block containing settings to define launch targets for Auto Scaling groups"
  type = object({
    instances_distribution = optional(object({
      on_demand_allocation_strategy            = optional(string)
      on_demand_base_capacity                  = optional(number)
      on_demand_percentage_above_base_capacity = optional(number)
      spot_allocation_strategy                 = optional(string)
      spot_instance_pools                      = optional(number)
      spot_max_price                           = optional(string)
    }))
    launch_template = object({
      override = optional(list(object({
        instance_requirements = optional(object({
          accelerator_count = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          accelerator_manufacturers = optional(list(string))
          accelerator_names         = optional(list(string))
          accelerator_total_memory_mib = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          accelerator_types      = optional(list(string))
          allowed_instance_types = optional(list(string))
          bare_metal             = optional(string)
          baseline_ebs_bandwidth_mbps = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          burstable_performance                                   = optional(string)
          cpu_manufacturers                                       = optional(list(string))
          excluded_instance_types                                 = optional(list(string))
          instance_generations                                    = optional(list(string))
          local_storage                                           = optional(string)
          local_storage_types                                     = optional(list(string))
          max_spot_price_as_percentage_of_optimal_on_demand_price = optional(number)
          memory_gib_per_vcpu = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          memory_mib = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          network_bandwidth_gbps = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          network_interface_count = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          on_demand_max_price_percentage_over_lowest_price = optional(number)
          require_hibernate_support                        = optional(bool)
          spot_max_price_percentage_over_lowest_price      = optional(number)
          total_local_storage_gb = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          vcpu_count = optional(object({
            max = optional(number)
            min = optional(number)
          }))
        }))
        instance_type = optional(string)
        launch_template_specification = optional(object({
          launch_template_id   = optional(string)
          launch_template_name = optional(string)
          version              = optional(string)
        }))
        weighted_capacity = optional(string)
      })))
    })
  })
  default = null
}

variable "name" {
  description = "Name used across the resources created"
  type        = string
}

variable "use_name_prefix" {
  description = "Determines whether to use `name` as is or create a unique name beginning with the `name` as the prefix"
  type        = bool
  default     = true
}

variable "placement_group" {
  description = "The name of the placement group into which you'll launch your instances, if any"
  type        = string
  default     = null
}

variable "protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events."
  type        = bool
  default     = false
}

variable "service_linked_role_arn" {
  description = "The ARN of the service-linked role that the ASG will use to call other AWS services"
  type        = string
  default     = null
}

variable "suspended_processes" {
  description = "A list of processes to suspend for the Auto Scaling Group. The allowed values are `Launch`, `Terminate`, `HealthCheck`, `ReplaceUnhealthy`, `AZRebalance`, `AlarmNotification`, `ScheduledActions`, `AddToLoadBalancer`, `InstanceRefresh`. Note that if you suspend either the `Launch` or `Terminate` process types, it can prevent your Auto Scaling Group from functioning properly"
  type        = list(string)
  default     = []
}

variable "autoscaling_group_tags" {
  description = "A map of additional tags to add to the autoscaling group"
  type        = map(string)
  default     = {}
}

variable "autoscaling_group_tags_not_propagate_at_launch" {
  description = "A list of tag keys that should NOT be propagated to launched EC2 instances"
  type        = list(string)
  default     = []
}

variable "instance_name" {
  description = "Name that is propogated to launched EC2 instances via a tag - if not provided, defaults to `var.name`"
  type        = string
  default     = ""
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the Auto Scaling Group should be terminated. The allowed values are `OldestInstance`, `NewestInstance`, `OldestLaunchConfiguration`, `ClosestToNextInstanceHour`, `OldestLaunchTemplate`, `AllocationStrategy`, `Default`"
  type        = list(string)
  default     = []
}

variable "vpc_zone_identifier" {
  description = "A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones`"
  type        = list(string)
  default     = null
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = string
  default     = null
}

variable "wait_for_elb_capacity" {
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over `min_elb_capacity` behavior."
  type        = number
  default     = null
}

variable "warm_pool" {
  description = "If this block is configured, add a Warm Pool to the specified Auto Scaling group"
  type = object({
    instance_reuse_policy = optional(object({
      reuse_on_scale_in = optional(bool)
    }))
    max_group_prepared_capacity = optional(number)
    min_size                    = optional(number)
    pool_state                  = optional(string)
  })
  default = null
}

variable "timeouts" {
  description = "Timeout configurations for the autoscaling group"
  type = object({
    delete = optional(string)
  })
  default = null
}

################################################################################
# Launch template
################################################################################

variable "create_launch_template" {
  description = "Determines whether to create launch template or not"
  type        = bool
  default     = true
}

variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type = list(object({
    device_name = optional(string)
    ebs = optional(object({
      delete_on_termination      = optional(bool)
      encrypted                  = optional(bool)
      iops                       = optional(number)
      kms_key_id                 = optional(string)
      snapshot_id                = optional(string)
      throughput                 = optional(number)
      volume_initialization_rate = optional(number)
      volume_size                = optional(number)
      volume_type                = optional(string)
    }))
    no_device    = optional(string)
    virtual_name = optional(string)
  }))
  default = null
}

variable "capacity_reservation_specification" {
  description = "Targeting for EC2 capacity reservations"
  type = object({
    capacity_reservation_preference = optional(string)
    capacity_reservation_target = optional(object({
      capacity_reservation_id                 = optional(string)
      capacity_reservation_resource_group_arn = optional(string)
    }))
  })
  default = null
}

variable "cpu_options" {
  description = "The CPU options for the instance"
  type = object({
    amd_sev_snp      = optional(string)
    core_count       = optional(number)
    threads_per_core = optional(number)
  })
  default = null
}

variable "credit_specification" {
  description = "Customize the credit specification of the instance"
  type = object({
    cpu_credits = optional(string)
  })
  default = null
}

variable "default_version" {
  description = "Default Version of the launch template"
  type        = string
  default     = null
}

variable "launch_template_description" {
  description = "Description of the launch template"
  type        = string
  default     = null
}

variable "disable_api_stop" {
  description = "If true, enables EC2 instance stop protection"
  type        = bool
  default     = null
}

variable "disable_api_termination" {
  description = "If true, enables EC2 instance termination protection"
  type        = bool
  default     = null
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = null
}

variable "enclave_options" {
  description = "Enable Nitro Enclaves on launched instances"
  type = object({
    enabled = optional(bool)
  })
  default = null
}

variable "hibernation_options" {
  description = "The hibernation options for the instance"
  type = object({
    configured = optional(bool)
  })
  default = null
}

variable "image_id" {
  description = "The AMI from which to launch the instance"
  type        = string
  default     = null
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance. Can be `stop` or `terminate`. (Default: `stop`)"
  type        = string
  default     = null
}

variable "instance_market_options" {
  description = "The market (purchasing) option for the instance"
  type = object({
    market_type = optional(string)
    spot_options = optional(object({
      block_duration_minutes         = optional(number)
      instance_interruption_behavior = optional(string)
      max_price                      = optional(string)
      spot_instance_type             = optional(string)
      valid_until                    = optional(string)
    }))
  })
  default = null
}


variable "instance_requirements" {
  description = "The attribute requirements for the type of instance. If present then `instance_type` cannot be present"
  type = object({
    accelerator_count = optional(object({
      max = optional(number)
      min = optional(number)
    }))
    accelerator_manufacturers = optional(list(string))
    accelerator_names         = optional(list(string))
    accelerator_total_memory_mib = optional(object({
      max = optional(number)
      min = optional(number)
    }))
    accelerator_types      = optional(list(string))
    allowed_instance_types = optional(list(string))
    bare_metal             = optional(string)
    baseline_ebs_bandwidth_mbps = optional(object({
      max = optional(number)
      min = optional(number)
    }))
    burstable_performance                                   = optional(string)
    cpu_manufacturers                                       = optional(list(string))
    excluded_instance_types                                 = optional(list(string))
    instance_generations                                    = optional(list(string))
    local_storage                                           = optional(string)
    local_storage_types                                     = optional(list(string))
    max_spot_price_as_percentage_of_optimal_on_demand_price = optional(number)
    memory_gib_per_vcpu = optional(object({
      max = optional(number)
      min = optional(number)
    }))
    memory_mib = optional(object({
      max = optional(number)
      min = optional(number)
    }))
    network_bandwidth_gbps = optional(object({
      max = optional(number)
      min = optional(number)
    }))
    network_interface_count = optional(object({
      max = optional(number)
      min = optional(number)
    }))
    on_demand_max_price_percentage_over_lowest_price = optional(number)
    require_hibernate_support                        = optional(bool)
    spot_max_price_percentage_over_lowest_price      = optional(number)
    total_local_storage_gb = optional(object({
      max = optional(number)
      min = optional(number)
    }))
    vcpu_count = optional(object({
      max = optional(number)
      min = string
    }))
  })
  default = null
}

variable "instance_type" {
  description = "The type of the instance. If present then `instance_requirements` cannot be present"
  type        = string
  default     = null
}

variable "kernel_id" {
  description = "The kernel ID"
  type        = string
  default     = null
}

variable "key_name" {
  description = "The key name that should be used for the instance"
  type        = string
  default     = null
}

variable "license_specifications" {
  description = "A list of license specifications to associate with"
  type = list(object({
    license_configuration_arn = string
  }))
  default = null
}

variable "launch_template_name" {
  description = "Name of launch template to be created"
  type        = string
  default     = ""
}

variable "launch_template_use_name_prefix" {
  description = "Determines whether to use `launch_template_name` as is or create a unique name beginning with the `launch_template_name` as the prefix"
  type        = bool
  default     = true
}

variable "maintenance_options" {
  description = "The maintenance options for the instance"
  type = object({
    auto_recovery = optional(string)
  })
  default = null
}

variable "metadata_options" {
  description = "Customize the metadata options for the instance"
  type = object({
    http_endpoint               = optional(string, "enabled")
    http_protocol_ipv6          = optional(string)
    http_put_response_hop_limit = optional(number, 1)
    http_tokens                 = optional(string, "required")
    instance_metadata_tags      = optional(string)
  })
  default = {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
}

variable "enable_monitoring" {
  description = "Enables/disables detailed monitoring"
  type        = bool
  default     = true
}

variable "network_interfaces" {
  description = "Customize network interfaces to be attached at instance boot time"
  type = list(object({
    associate_carrier_ip_address = optional(bool)
    associate_public_ip_address  = optional(bool)
    connection_tracking_specification = optional(object({
      tcp_established_timeout = optional(number)
      udp_stream_timeout      = optional(number)
      udp_timeout             = optional(number)
    }))
    delete_on_termination = optional(bool)
    description           = optional(string)
    device_index          = optional(number)
    ena_srd_specification = optional(object({
      ena_srd_enabled = optional(bool)
      ena_srd_udp_specification = optional(object({
        ena_srd_udp_enabled = optional(bool)
      }))
    }))
    interface_type       = optional(string)
    ipv4_address_count   = optional(number)
    ipv4_addresses       = optional(list(string))
    ipv4_prefix_count    = optional(number)
    ipv4_prefixes        = optional(list(string))
    ipv6_address_count   = optional(number)
    ipv6_addresses       = optional(list(string))
    ipv6_prefix_count    = optional(number)
    ipv6_prefixes        = optional(list(string))
    network_card_index   = optional(number)
    network_interface_id = optional(string)
    primary_ipv6         = optional(bool)
    private_ip_address   = optional(string)
    security_groups      = optional(list(string), [])
    subnet_id            = optional(string)
  }))
  default = null
}

variable "placement" {
  description = "The placement of the instance"
  type = object({
    affinity                = optional(string)
    availability_zone       = optional(string)
    group_name              = optional(string)
    host_id                 = optional(string)
    host_resource_group_arn = optional(string)
    partition_number        = optional(number)
    spread_domain           = optional(string)
    tenancy                 = optional(string)
  })
  default = null
}

variable "private_dns_name_options" {
  description = "The options for the instance hostname. The default values are inherited from the subnet"
  type = object({
    enable_resource_name_dns_aaaa_record = optional(bool)
    enable_resource_name_dns_a_record    = optional(bool)
    hostname_type                        = optional(string)
  })
  default = null
}

variable "ram_disk_id" {
  description = "The ID of the ram disk"
  type        = string
  default     = null
}

variable "tag_specifications" {
  description = "The tags to apply to the resources during launch"
  type = list(object({
    resource_type = optional(string)
    tags          = optional(map(string), {})
  }))
  default = null
}

variable "update_default_version" {
  description = "Whether to update Default Version each update. Conflicts with `default_version`"
  type        = bool
  default     = null
}

variable "user_data" {
  description = "The Base64-encoded user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "security_groups" {
  description = "A list of security group IDs to associate"
  type        = list(string)
  default     = []
}

variable "launch_template_tags" {
  description = "A map of additional tags to add to the launch template"
  type        = map(string)
  default     = {}
}

################################################################################
# Autoscaling group traffic source attachment
################################################################################

variable "traffic_source_attachments" {
  description = "Map of traffic source attachment definitions to create"
  type = map(object({
    traffic_source_identifier = string
    traffic_source_type       = optional(string, "elbv2")
  }))
  default = null
}

################################################################################
# Autoscaling group schedule
################################################################################

variable "schedules" {
  description = "Map of autoscaling group schedule to create"
  type = map(object({
    desired_capacity = optional(number)
    end_time         = optional(string)
    max_size         = optional(number)
    min_size         = optional(number)
    recurrence       = optional(string)
    start_time       = optional(string)
    time_zone        = optional(string)
  }))
  default = null
}

################################################################################
# Autoscaling policy
################################################################################

variable "scaling_policies" {
  description = "Map of target scaling policy schedule to create"
  type = map(object({
    adjustment_type           = optional(string)
    cooldown                  = optional(number)
    enabled                   = optional(bool)
    estimated_instance_warmup = optional(number)
    metric_aggregation_type   = optional(string)
    min_adjustment_magnitude  = optional(number)
    name                      = optional(string) # Will fall back to the map key if not provided
    policy_type               = optional(string)
    predictive_scaling_configuration = optional(object({
      max_capacity_breach_behavior = optional(string)
      max_capacity_buffer          = optional(number)
      metric_specification = object({
        customized_capacity_metric_specification = optional(object({
          metric_data_queries = optional(list(object({
            expression = optional(string)
            id         = string
            label      = optional(string)
            metric_stat = optional(object({
              metric = object({
                dimensions = optional(list(object({
                  name  = string
                  value = string
                })))
                metric_name = string
                namespace   = string
              })
              stat = string
              unit = optional(string)
            }))
            return_data = optional(bool)
          })))
        }))
        customized_load_metric_specification = optional(object({
          metric_data_queries = optional(list(object({
            expression = optional(string)
            id         = string
            label      = optional(string)
            metric_stat = optional(object({
              metric = object({
                dimensions = optional(list(object({
                  name  = string
                  value = string
                })))
                metric_name = string
                namespace   = string
              })
              stat = string
              unit = optional(string)
            }))
            return_data = optional(bool)
          })))
        }))
        customized_scaling_metric_specification = optional(object({
          metric_data_queries = optional(list(object({
            expression = optional(string)
            id         = string
            label      = optional(string)
            metric_stat = optional(object({
              metric = object({
                dimensions = optional(list(object({
                  name  = string
                  value = string
                })))
                metric_name = string
                namespace   = string
              })
              stat = string
              unit = optional(string)
            }))
            return_data = optional(bool)
          })))
        }))
        predefined_load_metric_specification = optional(object({
          predefined_metric_type = string
          resource_label         = optional(string)
        }))
        predefined_metric_pair_specification = optional(object({
          predefined_metric_type = string
          resource_label         = optional(string)
        }))
        predefined_scaling_metric_specification = optional(object({
          predefined_metric_type = string
          resource_label         = optional(string)
        }))
        target_value = optional(number)
      })
      mode                   = optional(string)
      scheduling_buffer_time = optional(number)
    }))
    scaling_adjustment = optional(number)
    step_adjustment = optional(list(object({
      metric_interval_lower_bound = optional(number)
      metric_interval_upper_bound = optional(number)
      scaling_adjustment          = number
    })))
    target_tracking_configuration = optional(object({
      customized_metric_specification = optional(object({
        metric_dimension = optional(list(object({
          name  = string
          value = string
        })))
        metric_name = optional(string)
        metrics = optional(list(object({
          expression = optional(string)
          id         = string
          label      = optional(string)
          metric_stat = optional(object({
            metric = object({
              dimensions = optional(list(object({
                name  = string
                value = string
              })))
              metric_name = string
              namespace   = string
            })
            period = optional(number)
            stat   = string
            unit   = optional(string)
          }))
          return_data = optional(bool)
        })))
        namespace = optional(string)
        period    = optional(number)
        statistic = optional(string)
        unit      = optional(string)
      }))
      disable_scale_in = optional(bool)
      predefined_metric_specification = optional(object({
        predefined_metric_type = string
        resource_label         = optional(string)
      }))
      target_value = number
    }))
  }))

  default = null
}

################################################################################
# IAM Role / Instance Profile
################################################################################

variable "create_iam_instance_profile" {
  description = "Determines whether an IAM instance profile is created or to use an existing IAM instance profile"
  type        = bool
  default     = false
}

variable "iam_instance_profile_arn" {
  description = "Amazon Resource Name (ARN) of an existing IAM instance profile. Used when `create_iam_instance_profile` = `false`"
  type        = string
  default     = null
}

variable "iam_instance_profile_name" {
  description = "The name of the IAM instance profile to be created (`create_iam_instance_profile` = `true`) or existing (`create_iam_instance_profile` = `false`)"
  type        = string
  default     = null
}

variable "iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "iam_role_use_name_prefix" {
  description = "Determines whether the IAM role name (`iam_role_name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "iam_role_path" {
  description = "IAM role path"
  type        = string
  default     = null
}

variable "iam_role_description" {
  description = "Description of the role"
  type        = string
  default     = null
}

variable "iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "iam_role_policies" {
  description = "IAM policies to attach to the IAM role"
  type        = map(string)
  default     = {}
}

variable "iam_role_tags" {
  description = "A map of additional tags to add to the IAM role created"
  type        = map(string)
  default     = {}
}

variable "putin_khuylo" {
  description = "Do you agree that Putin doesn't respect Ukrainian sovereignty and territorial integrity? More info: https://en.wikipedia.org/wiki/Putin_khuylo!"
  type        = bool
  default     = true
}
