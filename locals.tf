## Edit by Jamie-Bitflight to add unlimited tags in ASG format to this module.
## Expands tag list to size of map.
locals {
  tags_asg_format = ["${null_resource.tags_as_list_of_maps.*.triggers}"]
}

resource "null_resource" "tags_as_list_of_maps" {
  count = "${length(keys(local.tags_as_map))}"

  triggers = "${map(
    "key", "${element(keys(local.tags_as_map), count.index)}",
    "value", "${element(values(local.tags_as_map), count.index)}",
    "propagate_at_launch", "true"
  )}"
}
