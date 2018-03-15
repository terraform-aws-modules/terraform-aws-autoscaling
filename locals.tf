locals {
  # This whole block is dedicated to converting an input variable of map (same type as other resources) into asg
  # compatible format, which is a list of maps with the propagate_at_launch variable set at true.
  # Split the full_tags variable (map) into 2 lists in same order as the map

  tags_as_map = "${merge(var.tags_as_map, map("",""))}"

  tag_keys = "${keys(local.tags_as_map)}"

  tag_values = "${values(local.tags_as_map)}"

  list_blank = "${list()}"

  # Define a structure for the keys of the dicts that the asg block requires.
  key_list = "${list(
    "key",
    "value",
    "propagate_at_launch")}"

  # 10 lists containing values that will be zipmapped to the above structure later.
  list0_key = "${length(local.tag_keys) > 1 ? element(local.tag_keys, 1) : "key"}"
  list0_value = "${length(local.tag_keys) > 1 ? element(local.tag_keys, 1) : "value"}"
  list0 = "${list(
      local.list0_key,
      local.list0_value,
      "true"
    )
  }"
  
  list1_key = "${length(local.tag_keys) > 2 ? element(local.tag_keys, 2) : "key"}"
  list1_value = "${length(local.tag_keys) > 2 ? element(local.tag_keys, 2) : "value"}"
  list1 = "${list(
      local.list1_key,
      local.list1_value,
      "true"
    )
  }"
  
  list2_key = "${length(local.tag_keys) > 3 ? element(local.tag_keys, 3) : "key"}"
  list2_value = "${length(local.tag_keys) > 3 ? element(local.tag_keys, 3) : "value"}"
  list2 = "${list(
      local.list2_key,
      local.list2_value,
      "true"
    )
  }"
  
  list3_key = "${length(local.tag_keys) > 4 ? element(local.tag_keys, 4) : "key"}"
  list3_value = "${length(local.tag_keys) > 4 ? element(local.tag_keys, 4) : "value"}"
  list3 = "${list(
      local.list3_key,
      local.list3_value,
      "true"
    )
  }"
  
  list4_key = "${length(local.tag_keys) > 5 ? element(local.tag_keys, 5) : "key"}"
  list4_value = "${length(local.tag_keys) > 5 ? element(local.tag_keys, 5) : "value"}"
  list4 = "${list(
      local.list4_key,
      local.list4_value,
      "true"
    )
  }"
  
  list5_key = "${length(local.tag_keys) > 6 ? element(local.tag_keys, 6) : "key"}"
  list5_value = "${length(local.tag_keys) > 6 ? element(local.tag_keys, 6) : "value"}"
  list5 = "${list(
      local.list5_key,
      local.list5_value,
      "true"
    )
  }"
  
  list6_key = "${length(local.tag_keys) > 7 ? element(local.tag_keys, 7) : "key"}"
  list6_value = "${length(local.tag_keys) > 7 ? element(local.tag_keys, 7) : "value"}"
  list6 = "${list(
      local.list6_key,
      local.list6_value,
      "true"
    )
  }"
  
  list7_key = "${length(local.tag_keys) > 8 ? element(local.tag_keys, 8) : "key"}"
  list7_value = "${length(local.tag_keys) > 8 ? element(local.tag_keys, 8) : "value"}"
  list7 = "${list(
      local.list7_key,
      local.list7_value,
      "true"
    )
  }"
  
  list8_key = "${length(local.tag_keys) > 9 ? element(local.tag_keys, 9) : "key"}"
  list8_value = "${length(local.tag_keys) > 9 ? element(local.tag_keys, 9) : "value"}"
  list8 = "${list(
      local.list8_key,
      local.list8_value,
      "true"
    )
  }"
  
  list9_key = "${length(local.tag_keys) > 10 ? element(local.tag_keys, 10) : "key"}"
  list9_value = "${length(local.tag_keys) > 10 ? element(local.tag_keys, 10) : "value"}"
  list9 = "${list(
      local.list9_key,
      local.list9_value,
      "true"
    )
  }"

  # Construct list of dicts in required format by zipmapping the value lists with the standard key list
  # Slicing to the length of the map of tags so we dont get blank or repeating tags
  tags_asg_format = "${slice(list(
      zipmap(
        local.key_list,
        local.list0
      ),
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
