locals {
  # This whole block is dedicated to converting an input variable of map (same type as other resources) into asg
  # compatible format, which is a list of maps with the propagate_at_launch variable set at true.
  # Split the full_tags variable (map) into 2 lists in same order as the map
  tag_keys = "${keys(var.tags_as_map)}"

  tag_values = "${values(var.tags_as_map)}"

  list_blank = "${list()}"

  # Define a structure for the keys of the dicts that the asg block requires.
  key_list = "${list(
    "key",
    "value",
    "propagate_at_launch")}"

  # 10 lists containing values that will be zipmapped to the above structure later.
  list0 = "${list(
      element(local.tag_keys, 0) != "" ? element(local.tag_keys, 0) : "",
      element(local.tag_values, 0) != "" ? element(local.tag_values, 0) : "",
      "true"
    )
  }"

  list1 = "${list(
      element(local.tag_keys, 1) != "" ? element(local.tag_keys, 1) : "",
      element(local.tag_values, 1) != "" ? element(local.tag_values, 1) : "",
      "true"
    )
  }"

  list2 = "${list(
      element(local.tag_keys, 2) != "" ? element(local.tag_keys, 2) : "",
      element(local.tag_values, 2) != "" ? element(local.tag_values, 2) : "",
      "true"
    )
  }"

  list3 = "${list(
      element(local.tag_keys, 3) != "" ? element(local.tag_keys, 3) : "",
      element(local.tag_values, 3) != "" ? element(local.tag_values, 3) : "",
      "true"
    )
  }"

  list4 = "${list(
      element(local.tag_keys, 4) != "" ? element(local.tag_keys, 4) : "",
      element(local.tag_values, 4) != "" ? element(local.tag_values, 4) : "",
      "true"
    )
  }"

  list5 = "${list(
      element(local.tag_keys, 5) != "" ? element(local.tag_keys, 5) : "",
      element(local.tag_values, 5) != "" ? element(local.tag_values, 5) : "",
      "true"
    )
  }"

  list6 = "${list(
      element(local.tag_keys, 6) != "" ? element(local.tag_keys, 6) : "",
      element(local.tag_values, 6) != "" ? element(local.tag_values, 6) : "",
      "true"
    )
  }"

  list7 = "${list(
      element(local.tag_keys, 7) != "" ? element(local.tag_keys, 7) : "",
      element(local.tag_values, 7) != "" ? element(local.tag_values, 7) : "",
      "true"
    )
  }"

  list8 = "${list(
      element(local.tag_keys, 8) != "" ? element(local.tag_keys, 8) : "",
      element(local.tag_values, 8) != "" ? element(local.tag_values, 8) : "",
      "true"
    )
  }"

  list9 = "${list(
    element(local.tag_keys, 9) != "" ? element(local.tag_keys, 9) : "",
    element(local.tag_values, 9) != "" ? element(local.tag_values, 9) : "",
    "true"
  )
  }"

  # Construct list of dicts in required format by zipmapping the value lists with the standard key list
  # Slicing to the length of the map of tags so we dont get blank or repeating tags
  tags_asg_format = "${slice(list(
      zipmap(
        local.key_list,
        local.list0
      ) ,
      zipmap(
        local.key_list,
        local.list1
      ),
      zipmap(
        local.key_list,
        local.list2
      ),
      zipmap(
        local.key_list,
        local.list3
      ),
      zipmap(
        local.key_list,
        local.list4
      ),
      zipmap(
        local.key_list,
        local.list5
      ),
      zipmap(
        local.key_list,
        local.list6
      ),
      zipmap(
        local.key_list,
        local.list7
      ),
      zipmap(
        local.key_list,
        local.list8
      ),
      zipmap(
        local.key_list,
        local.list9
      )
    ), 0, length(local.tag_keys) - 1)
  }"
}
