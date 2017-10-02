#######################
# Launch configuration
#######################
module "launch_configuration" {
  source = "./modules/launch_configuration"

  count = "${var.existing_launch_configuration != "" ? 0 : 1}"

  name                        = "${var.lc_name}"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${var.iam_instance_profile}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${var.security_groups}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data                   = "${var.user_data}"
  enable_monitoring           = "${var.enable_monitoring}"
  spot_price                  = "${var.spot_price}"
  placement_tenancy           = "${var.placement_tenancy}"

  ebs_optimized          = "${var.ebs_optimized}"
  ebs_block_device       = "${var.ebs_block_device}"
  ephemeral_block_device = "${var.ephemeral_block_device}"
  root_block_device      = "${var.root_block_device}"
}

####################
# Autoscaling Group
####################
module "autoscaling_group" {
  source = "./modules/autoscaling_group"

  name                 = "${var.asg_name}"
  launch_configuration = "${var.existing_launch_configuration != "" ? var.existing_launch_configuration : module.launch_configuration.this_launch_configuration_id}"
  vpc_zone_identifier  = ["${var.vpc_zone_identifier}"]

  max_size         = "${var.max_size}"
  min_size         = "${var.min_size}"
  desired_capacity = "${var.desired_capacity}"

  load_balancers            = ["${var.load_balancers}"]
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"

  min_elb_capacity          = "${var.min_elb_capacity}"
  wait_for_elb_capacity     = "${var.wait_for_elb_capacity}"
  target_group_arns         = ["${var.target_group_arns}"]
  default_cooldown          = "${var.default_cooldown}"
  force_delete              = "${var.force_delete}"
  termination_policies      = "${var.termination_policies}"
  suspended_processes       = "${var.suspended_processes}"
  placement_group           = "${var.placement_group}"
  enabled_metrics           = ["${var.enabled_metrics}"]
  metrics_granularity       = "${var.metrics_granularity}"
  wait_for_capacity_timeout = "${var.wait_for_capacity_timeout}"
  protect_from_scale_in     = "${var.protect_from_scale_in}"

  tags = "${var.tags}"
}
