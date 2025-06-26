# Upgrade from v8.x to v9.x

If you have any questions regarding this upgrade process, please consult the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/complete) directory:
If you find a bug, please open an issue with supporting configuration to reproduce.

## List of backwards incompatible changes

- Terraform v1.5.7 is now minimum supported version
- AWS provider v6.0.0 is now minimum supported version

## Additional changes

### Added

- Support for `region` parameter to specify the AWS region for the resources created if different from the provider region.

### Modified

- Variable definitions now contain detailed `object` types in place of the previously used any type.
- `mixed_instances_policy` `override` is now wrapped behind `launch_template` to match API
- IMDSv2 is now enforced by default with a hop limit set to 1

### Variable and output changes

1. Removed variables:

    - `create_scaling_policy`
    - `create_schedule`
    - `elastic_gpu_specifications` removed in `v6.0.0` of the AWS provider
    - `elastic_inference_accelerator` removed in `v6.0.0` of the AWS provider

2. Renamed variables:

    - `delete_timeout` -> `timeouts`

3. Added variables:

    - `autoscaling_group_tags_not_propagate_at_launch`
    - `context`

4. Removed outputs:

    - None

5. Renamed outputs:

    - None

6. Added outputs:

    - None

## Upgrade Migrations

### Before 8.x Example

```hcl
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 8.0"

  # Truncated for brevity

  override = [
    {
      instance_type     = "t3.nano"
      weighted_capacity = "2"
    },
    {
      instance_type     = "t3.medium"
      weighted_capacity = "1"
    },
  ]
  ...
}
```

### After 9.x Example

```hcl
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 9.0"

  # Truncated for brevity
  launch_template = {
    override = [
      {
        instance_type     = "t3.nano"
        weighted_capacity = "2"
      },
      {
        instance_type     = "t3.medium"
        weighted_capacity = "1"
      },
    ]
  }
  ...
}
```

### State Changes

There are no required state changes to migrate from `v8.x` to `v9.x`.
