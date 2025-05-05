module "wrapper" {
  source  = "../"
  for_each = var.items

  ################################################################################
  # Autoscaling group
  ################################################################################

  create                             = try(each.value.create, var.defaults.create, true)
  ignore_desired_capacity_changes    = try(each.value.ignore_desired_capacity_changes, var.defaults.ignore_desired_capacity_changes, false)
  name                               = try(each.value.name, var.defaults.name)
  use_name_prefix                    = try(each.value.use_name_prefix, var.defaults.use_name_prefix, true)
  instance_name                      = try(each.value.instance_name, var.defaults.instance_name, "")
  launch_template_id                 = try(each.value.launch_template_id, var.defaults.launch_template_id, null)
  launch_template_version            = try(each.value.launch_template_version, var.defaults.launch_template_version, null)
  availability_zones                 = try(each.value.availability_zones, var.defaults.availability_zones, null)
  availability_zone_distribution     = try(each.value.availability_zone_distribution, var.defaults.availability_zone_distribution, {})
  vpc_zone_identifier                = try(each.value.vpc_zone_identifier, var.defaults.vpc_zone_identifier, null)
  min_size                           = try(each.value.min_size, var.defaults.min_size, null)
  max_size                           = try(each.value.max_size, var.defaults.max_size, null)
  desired_capacity                   = try(each.value.desired_capacity, var.defaults.desired_capacity, null)
  desired_capacity_type              = try(each.value.desired_capacity_type, var.defaults.desired_capacity_type, null)
  capacity_rebalance                 = try(each.value.capacity_rebalance, var.defaults.capacity_rebalance, null)
  min_elb_capacity                   = try(each.value.min_elb_capacity, var.defaults.min_elb_capacity, null)
  wait_for_elb_capacity              = try(each.value.wait_for_elb_capacity, var.defaults.wait_for_elb_capacity, null)
  wait_for_capacity_timeout          = try(each.value.wait_for_capacity_timeout, var.defaults.wait_for_capacity_timeout, null)
  default_cooldown                   = try(each.value.default_cooldown, var.defaults.default_cooldown, null)
  default_instance_warmup            = try(each.value.default_instance_warmup, var.defaults.default_instance_warmup, null)
  protect_from_scale_in              = try(each.value.protect_from_scale_in, var.defaults.protect_from_scale_in, false)
  placement_group                    = try(each.value.placement_group, var.defaults.placement_group, null)
  health_check_type                  = try(each.value.health_check_type, var.defaults.health_check_type, null)
  health_check_grace_period          = try(each.value.health_check_grace_period, var.defaults.health_check_grace_period, null)
  force_delete                       = try(each.value.force_delete, var.defaults.force_delete, null)
  termination_policies               = try(each.value.termination_policies, var.defaults.termination_policies, [])
  suspended_processes                = try(each.value.suspended_processes, var.defaults.suspended_processes, [])
  max_instance_lifetime              = try(each.value.max_instance_lifetime, var.defaults.max_instance_lifetime, null)
  enabled_metrics                    = try(each.value.enabled_metrics, var.defaults.enabled_metrics, [])
  metrics_granularity                = try(each.value.metrics_granularity, var.defaults.metrics_granularity, null)
  service_linked_role_arn            = try(each.value.service_linked_role_arn, var.defaults.service_linked_role_arn, null)
  initial_lifecycle_hooks            = try(each.value.initial_lifecycle_hooks, var.defaults.initial_lifecycle_hooks, [])
  instance_refresh                   = try(each.value.instance_refresh, var.defaults.instance_refresh, {})
  use_mixed_instances_policy         = try(each.value.use_mixed_instances_policy, var.defaults.use_mixed_instances_policy, false)
  mixed_instances_policy             = try(each.value.mixed_instances_policy, var.defaults.mixed_instances_policy, null)
  delete_timeout                     = try(each.value.delete_timeout, var.defaults.delete_timeout, null)
  tags                               = try(each.value.tags, var.defaults.tags, {})
  warm_pool                          = try(each.value.warm_pool, var.defaults.warm_pool, {})
  ebs_optimized                      = try(each.value.ebs_optimized, var.defaults.ebs_optimized, null)
  image_id                           = try(each.value.image_id, var.defaults.image_id, "")
  instance_type                      = try(each.value.instance_type, var.defaults.instance_type, null)
  instance_requirements              = try(each.value.instance_requirements, var.defaults.instance_requirements, {})
  key_name                           = try(each.value.key_name, var.defaults.key_name, null)
  user_data                          = try(each.value.user_data, var.defaults.user_data, null)
  security_groups                    = try(each.value.security_groups, var.defaults.security_groups, [])
  enable_monitoring                  = try(each.value.enable_monitoring, var.defaults.enable_monitoring, true)
  metadata_options                   = try(each.value.metadata_options, var.defaults.metadata_options, {})
  autoscaling_group_tags             = try(each.value.autoscaling_group_tags, var.defaults.autoscaling_group_tags, {})
  ignore_failed_scaling_activities   = try(each.value.ignore_failed_scaling_activities, var.defaults.ignore_failed_scaling_activities, false)
  instance_maintenance_policy        = try(each.value.instance_maintenance_policy, var.defaults.instance_maintenance_policy, {})

  ################################################################################
  # Launch template
  ################################################################################

  create_launch_template                = try(each.value.create_launch_template, var.defaults.create_launch_template, true)
  launch_template_name                  = try(each.value.launch_template_name, var.defaults.launch_template_name, "")
  launch_template_use_name_prefix       = try(each.value.launch_template_use_name_prefix, var.defaults.launch_template_use_name_prefix, true)
  launch_template_description           = try(each.value.launch_template_description, var.defaults.launch_template_description, null)
  default_version                       = try(each.value.default_version, var.defaults.default_version, null)
  update_default_version                = try(each.value.update_default_version, var.defaults.update_default_version, null)
  disable_api_termination               = try(each.value.disable_api_termination, var.defaults.disable_api_termination, null)
  disable_api_stop                      = try(each.value.disable_api_stop, var.defaults.disable_api_stop, null)
  instance_initiated_shutdown_behavior  = try(each.value.instance_initiated_shutdown_behavior, var.defaults.instance_initiated_shutdown_behavior, null)
  kernel_id                             = try(each.value.kernel_id, var.defaults.kernel_id, null)
  ram_disk_id                           = try(each.value.ram_disk_id, var.defaults.ram_disk_id, null)
  block_device_mappings                 = try(each.value.block_device_mappings, var.defaults.block_device_mappings, [])
  capacity_reservation_specification    = try(each.value.capacity_reservation_specification, var.defaults.capacity_reservation_specification, {})
  cpu_options                           = try(each.value.cpu_options, var.defaults.cpu_options, {})
  credit_specification                  = try(each.value.credit_specification, var.defaults.credit_specification, {})
  elastic_gpu_specifications            = try(each.value.elastic_gpu_specifications, var.defaults.elastic_gpu_specifications, {})
  elastic_inference_accelerator         = try(each.value.elastic_inference_accelerator, var.defaults.elastic_inference_accelerator, {})
  enclave_options                       = try(each.value.enclave_options, var.defaults.enclave_options, {})
  hibernation_options                   = try(each.value.hibernation_options, var.defaults.hibernation_options, {})
  instance_market_options               = try(each.value.instance_market_options, var.defaults.instance_market_options, {})
  license_specifications                = try(each.value.license_specifications, var.defaults.license_specifications, {})
  maintenance_options                   = try(each.value.maintenance_options, var.defaults.maintenance_options, {})
  network_interfaces                    = try(each.value.network_interfaces, var.defaults.network_interfaces, [])
  placement                             = try(each.value.placement, var.defaults.placement, {})
  private_dns_name_options              = try(each.value.private_dns_name_options, var.defaults.private_dns_name_options, {})
  tag_specifications                    = try(each.value.tag_specifications, var.defaults.tag_specifications, [])
  launch_template_tags                  = try(each.value.launch_template_tags, var.defaults.launch_template_tags, {})

  ################################################################################
  # Autoscaling group traffic source attachment
  ################################################################################

  traffic_source_attachments         = try(each.value.traffic_source_attachments, var.defaults.traffic_source_attachments, {})

  ################################################################################
  # Autoscaling group schedule
  ################################################################################

  create_schedule                    = try(each.value.create_schedule, var.defaults.create_schedule, true)
  schedules                          = try(each.value.schedules, var.defaults.schedules, {})

  ################################################################################
  # Autoscaling policy
  ################################################################################

  create_scaling_policy             = try(each.value.create_scaling_policy, var.defaults.create_scaling_policy, true)
  scaling_policies                  = try(each.value.scaling_policies, var.defaults.scaling_policies, {})

  ################################################################################
  # IAM Role / Instance Profile
  ################################################################################

  create_iam_instance_profile        = try(each.value.create_iam_instance_profile, var.defaults.create_iam_instance_profile, false)
  iam_instance_profile_arn           = try(each.value.iam_instance_profile_arn, var.defaults.iam_instance_profile_arn, null)
  iam_instance_profile_name          = try(each.value.iam_instance_profile_name, var.defaults.iam_instance_profile_name, null)
  iam_role_name                      = try(each.value.iam_role_name, var.defaults.iam_role_name, null)
  iam_role_use_name_prefix           = try(each.value.iam_role_use_name_prefix, var.defaults.iam_role_use_name_prefix, true)
  iam_role_path                      = try(each.value.iam_role_path, var.defaults.iam_role_path, null)
  iam_role_description               = try(each.value.iam_role_description, var.defaults.iam_role_description, null)
  iam_role_permissions_boundary      = try(each.value.iam_role_permissions_boundary, var.defaults.iam_role_permissions_boundary, null)
  iam_role_policies                  = try(each.value.iam_role_policies, var.defaults.iam_role_policies, {})
  iam_role_tags                      = try(each.value.iam_role_tags, var.defaults.iam_role_tags, {})
  putin_khuylo                       = try(each.value.putin_khuylo, var.defaults.putin_khuylo, true)
}
