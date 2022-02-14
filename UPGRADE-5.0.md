# Upgrade from v4.x to v5.x

If you have any questions regarding this upgrade process, please consult the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/complete) directory:

⚠️ Instructions detailed here are for migrating from `v4.x` to `v5.x`. For instructions on upgrading to `v4.x` first, please see [UPGRADE-4.0.md](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/blob/master/UPGRADE-4.0.md).

If you find a bug, please open an issue with supporting configuration to reproduce.

## List of backwards incompatible changes

- Launch configuration support has been removed. [AWS has stated that launch configurations will no longer receive updates](https://aws.amazon.com/blogs/compute/amazon-ec2-auto-scaling-will-no-longer-add-support-for-new-ec2-features-to-launch-configurations/) and that launch templates should be used since they are the successor.

## Additional changes

### Added

- A second autoscaling group `idc` (ignore desired capacity) has been added to allow users to utilize an autoscaling group that will ignore changes to `desired_capacity`

### Modified

- `var.tags` was previously a list of maps of `key`, `value`, and `propagate_at_launch`. It has been changed to a standard map of `key` = `value` pairs
- The use of `for_each = lookup(map.value, "attr", null) != null ? [map.value.attr] : []` pattern has been replaced with a more concise, readable pattern of `for_each = can(map.value.attr) ? [map.value.attr] : []`. This is a no-op change for users

### Variable and output changes

1. Removed variables:

    - `propagate_name`
    - `tags_as_map` (use `tags` instead)
    - `use_lt` -> this is now the default; only launch templates are supported
    - `launch_configuration`
    - `create_lc`
    - `use_lc`
    - `lc_name`
    - `lc_use_name_prefix`
    - `user_data`
    - `associate_public_ip_address`
    - `spot_price`
    - `placement_tenancy`
    - `ebs_block_device`
    - `ephemeral_block_device`
    - `root_block_device`

2. Renamed variables:

    - `create_asg` -> `create`
    - `create_lt` -> `create_launch_template`
    - `lt_name` -> `launch_template_name`
    - `lt_use_name_prefix` -> `launch_template_use_name_prefix`
    - `lt_version` -> `launch_template_version`

3. Added variables:

    - `ignore_desired_capacity_changes` -> to flip between using a standard autoscaling group that respects `desired_capacity` setting or one that ignores

4. Removed outputs:

    - `launch_configuration_id`
    - `launch_configuration_arn`
    - `launch_configuration_name`

5. Renamed outputs:

    - None

6. Added outputs:

    - None

## Upgrade Migrations

### Before 4.x Example

```hcl
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 4.0"

  # Autoscaling group
  name = "example-asg"

  min_size            = 0
  max_size            = 1
  desired_capacity    = 1
  health_check_type   = "EC2"
  vpc_zone_identifier = ["subnet-1235678", "subnet-87654321"]

  # Launch template
  lt_name                = "example-asg"
  description            = "Launch template example"
  update_default_version = true
  use_lt                 = true
  create_lt              = true

  image_id      = "ami-ebd02392"
  instance_type = "t3.micro"

  tags_as_map = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }
}
```

### After 5.x Example

```hcl
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 5.0"

  # Autoscaling group
  name = "example-asg"

  min_size            = 0
  max_size            = 1
  desired_capacity    = 1
  health_check_type   = "EC2"
  vpc_zone_identifier = ["subnet-1235678", "subnet-87654321"]

  # Launch template
  launch_template_name        = "example-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true

  image_id      = "ami-ebd02392"
  instance_type = "t3.micro"

  tags = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }
}
```

### State Changes

There are no required state changes to migrate from `v4.x` to `v5.x`. If you are using launch configuration support, you can continue to do so with the `v4.x` version pinned or evaluate switching to a new autoscaling group that is backed by launch templates.

If you wish to opt into the new feature `ignore_desired_capacity_changes`, you can perform the following state mv commands on your group(s) if desired:

ℹ️ Be sure to add the `ignore_desired_capacity_changes = true` to your configuration.

```bash
terraform state mv 'module.<xxx>.aws_autoscaling_group.this[0]' 'module.<xxx>.aws_autoscaling_group.idc[0]'
```

For example, if you previously had a configuration such as (truncated for brevity):

```hcl
module "example" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 4.x"

  # <your configs>
}
```

After updating the configuration to the latest `v5.x` changes:

```hcl
module "example" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 5.x"

  # <your configs>

  ignore_desired_capacity_changes = true
}
```

The associated Terraform state move command would be:

```bash
terraform state mv 'module.example.aws_autoscaling_group.this[0]' 'module.example.aws_autoscaling_group.idc[0]'
```
