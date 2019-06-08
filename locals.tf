locals {
  tags_asg_format = null_resource.tags_as_list_of_maps.*.triggers
}

resource "null_resource" "tags_as_list_of_maps" {
  count = length(keys(var.tags_as_map))

  triggers = {
    "key"                 = keys(var.tags_as_map)[count.index]
    "value"               = values(var.tags_as_map)[count.index]
    "propagate_at_launch" = "true"
  }
}
