# Upgrade from v7.x to v8.x

If you have any questions regarding this upgrade process, please consult the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/complete) directory:
If you find a bug, please open an issue with supporting configuration to reproduce.

## List of backwards incompatible changes

- `target_group_arns` and `load_balancers` are no longer supported on the ASG; instead users should use the `traffic_source_attachments` which cover this functionality and more
- Users can now create multiple `traffic_source_attachments` instead of previously where the module only supported one attachment
- The minimum supported version of Terraform has been raised to `v1.3`

## Additional changes

### Added

- None

### Modified

- None

### Variable and output changes

1. Removed variables:

    - `load_balancers`
    - `target_group_arns`
    - `create_traffic_source_attachment`
    - `traffic_source_identifier`
    - `traffic_source_type`

2. Renamed variables:

    - None

3. Added variables:

    - `traffic_source_attachments`

4. Removed outputs:

    - `launch_configuration_id`
    - `launch_configuration_arn`
    - `launch_configuration_name`

5. Renamed outputs:

    - None

6. Added outputs:

    - None

## Upgrade Migrations

### Before 7.x Example

```hcl
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 7.0"

  # Truncated for brevity

  # Traffic source attachment
  create_traffic_source_attachment = true
  traffic_source_identifier        = "arn:aws:elasticloadbalancing:us-east-2:123456789012:loadbalancer/app/my-load-balancer/1234567890123456"
  traffic_source_type              = "elbv2"

  ...
}
```

### After 8.x Example

```hcl
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 8.0"

  # Truncated for brevity

  traffic_source_attachments = {
    ex-alb = {
      traffic_source_identifier = "arn:aws:elasticloadbalancing:us-east-2:123456789012:loadbalancer/app/my-load-balancer/1234567890123456"
      traffic_source_type       = "elbv2"
    }
    ...
  }
  ...
}
```

### State Changes

There are no required state changes to migrate from `v7.x` to `v8.x`.
