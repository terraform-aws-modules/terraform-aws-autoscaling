# Upgrade from v3.x to v4.x

If you have any questions regarding this upgrade process, please consult the `examples` directory:

- [Complete](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/tree/master/examples/complete)

If you find a bug, please open an issue with supporting configuration to reproduce.

:warning: Note - due to the nature of the default use of `name_prefix`, nearly all paths to upgrade will require recreating the resources provisioned by the module. For most use cases this should be ok as autoscaling groups are intended to be ephemeral; nonetheless, please be aware.

For most users, you will need to add the following variables and their appropriate values:

```hcl
  # This matches most of the current use cases where the launch configuration is created by the module
  lc_name   = "module-will-create"
  use_lc    = true
  create_lc = true
```

If you are using an externally created launch configuration:

```hcl
  lc_name   = "externally-created"
  use_lc    = true
```

## List of backwards incompatible changes

### Variable and output changes

1. Removed variables:

   - `recreate_asg_when_lc_changes`
   - `asg_name`

2. Renamed variables:

   - See below for initial lifecycle hook variable changes

3. Renamed outputs:

   - `this_<remaining-name>` => `<remaining-name>` (remove leading `this_`)

### Initial lifecycle hook

If utilizing the initial lifecycle hook, you will need to perform the following change as this configuration has been folded into one resource with dynamic configuration blocks which allows for more than one lifecycle hook.

Change the lifecycle hook configuration values in use from:

```hcl
...
  initial_lifecycle_hook_name                    = "something"
  initial_lifecycle_hook_lifecycle_transition    = "something"
  initial_lifecycle_hook_notification_metadata   = "something"
  initial_lifecycle_hook_heartbeat_timeout       = "something"
  initial_lifecycle_hook_notification_target_arn = "something"
  initial_lifecycle_hook_role_arn                = "something"
  initial_lifecycle_hook_default_result          = "something"
...
```

to the following:

```hcl
...
  initial_lifecycle_hooks = [
    {
      name                    = "something"
      default_result          = "something"
      heartbeat_timeout       = "something"
      lifecycle_transition    = "something"
      notification_metadata   = "something"
      notification_target_arn = "something"
      role_arn                = "something"
    }
...
```

### ASG Recreate/Refresh

v3.x of this module used a `random_pet` resource to create a random name for the autoscaling group to force the autoscaling group to be re-created when the launch configuration was changed, causing the instances to be removed and re-provisioned each time there was a launch configuration update (if `recreate_asg_when_lc_changes = true` was set). This resource has been removed and in its place there is now a set of functionality provided by AWS and the Terraform AWS provider - `instance_refresh`. By default, a refresh will always be triggered by a change in any of `launch_configuration`, `launch_template`, or `mixed_instances_policy` when `instance_refresh` is enabled. Therefore, to continue using the instance replacement functionality of v3.x, simply provide an `instance_refresh` configuration and instances will be replaced on each change to the stated resources without needing to re-create the autoscaling group. If you would like the instances to be replace on additional changes not contained in `launch_configuration`, `launch_template`, or `mixed_instances_policy`, you can set the appropriate value in the `triggers = []` value.

```hcl
  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }
```
