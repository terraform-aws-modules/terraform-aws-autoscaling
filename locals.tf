locals {
  tags_asg_format = ["${null_resource.tags_as_list_of_maps.*.triggers}"]

  all_notification_types = "${join(",", list(
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
    "autoscaling:TEST_NOTIFICATION",
  ))}"
}

resource "null_resource" "tags_as_list_of_maps" {
  count = "${length(keys(var.tags_as_map))}"

  triggers = "${map(
    "key", "${element(keys(var.tags_as_map), count.index)}",
    "value", "${element(values(var.tags_as_map), count.index)}",
    "propagate_at_launch", "true"
  )}"
}
