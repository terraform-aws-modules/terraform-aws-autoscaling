# Changelog

All notable changes to this project will be documented in this file.

## [9.0.1](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v9.0.0...v9.0.1) (2025-07-02)


### Bug Fixes

* Correct null check between two definitions of ASG ([#295](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/295)) ([3659f3e](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/3659f3e33e71b981175dd35735ef1f668ead1ed9))

## [9.0.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v8.3.1...v9.0.0) (2025-06-26)


### ⚠ BREAKING CHANGES

* Upgrade AWS provider and min required Terraform version to `6.0` and `1.5.7` respectively (#294)

### Features

* Upgrade AWS provider and min required Terraform version to `6.0` and `1.5.7` respectively ([#294](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/294)) ([bcc2455](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/bcc24551a4f1b7740b91397c79444bc62eae577c))

## [8.3.1](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v8.3.0...v8.3.1) (2025-06-25)


### Bug Fixes

* Restrict AWS provider version from using `v6.x` which contains breaking changes ([#293](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/293)) ([6623981](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/66239812b6afeafc9ecde97f0fef51d8f3fd0dda))

## [8.3.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v8.2.0...v8.3.0) (2025-05-05)


### Features

* Add Terragrunt wrapper generation ([#287](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/287)) ([b625533](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/b6255333d34af23e752f159c9db8bab50016ecca))

## [8.2.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v8.1.0...v8.2.0) (2025-03-29)


### Features

* Add specific variables to add tags to launch template ([#285](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/285)) ([d509000](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/d509000a1f1b7c9444e6ffa47584f75ca84b74fc))

## [8.1.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v8.0.1...v8.1.0) (2025-02-14)


### Features

* Add support for `primary_ipv6` in launch template ([#283](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/283)) ([061dce6](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/061dce6308d8ada4348b1bcf76492cd7c188ea6c))

## [8.0.1](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v8.0.0...v8.0.1) (2024-12-20)


### Bug Fixes

* Update CI workflow versions to latest ([#280](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/280)) ([ea61a31](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/ea61a3179d7f3afb75a8ceda751a239ae4f43ae5))

## [8.0.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v7.7.0...v8.0.0) (2024-08-13)


### ⚠ BREAKING CHANGES

* Allow multiple traffic source attachments (#273)

### Features

* Allow multiple traffic source attachments ([#273](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/273)) ([3782413](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/37824138e8d98fc8179177bc5c92880be2282d84))

## [7.7.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v7.6.1...v7.7.0) (2024-07-07)


### Features

* Support `max_spot_price_as_percentage_of_optimal_on_demand_price` ([#276](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/276)) ([02251e3](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/02251e3f67fb34e28e465fc449b92338e07f4fc9))

## [7.6.1](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v7.6.0...v7.6.1) (2024-06-20)


### Bug Fixes

* Argument `update_default_version` type should be a `bool` ([#272](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/272)) ([28521c4](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/28521c48b184fb06faafd4800ece29bb520cd3db))

## [7.6.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v7.5.0...v7.6.0) (2024-06-03)


### Features

* Support Alarm Specification in Instance Refresh Preferences ([#271](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/271)) ([8c319c0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/8c319c03bd108b1ff5f79f24d1989f8b9758cfec))

## [7.5.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v7.4.1...v7.5.0) (2024-05-28)


### Features

* Add `allowed_instance_types` to `instance_requirements` ([#267](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/267)) ([09d8e0f](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/09d8e0fcd4536bd05208ad9226076bccf9b6178a)), closes [#265](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/265)

## [7.4.1](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v7.4.0...v7.4.1) (2024-03-07)


### Bug Fixes

* Update CI workflow versions to remove deprecated runtime warnings ([#258](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/258)) ([06f666f](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/06f666f7a5cd879ee7fbcd3863f88b9867cfa531))

## [7.4.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v7.3.1...v7.4.0) (2024-02-21)


### Features

* Adds `max_healthy_percentage` and `skip_matching` to autoscaling group ([#256](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/256)) ([faf98ef](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/faf98efecc626816bc3bbe226e2e4da8b9372dc8))

### [7.3.1](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v7.3.0...v7.3.1) (2023-11-30)


### Bug Fixes

* Ignore changes to `load_balancers` and `target_group_arns` ([#252](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/252)) ([ef8235c](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/ef8235c27775e5a529b830c810ba4f90b291ea54))

## [7.3.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v7.2.0...v7.3.0) (2023-11-22)


### Features

* Add `instance_maintenance_policy` to autoscaling group ([#251](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/251)) ([d9bf968](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/d9bf96889c634fa98e6a59a86154085f163d74b0))

## [7.2.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v7.1.0...v7.2.0) (2023-11-02)


### Features

* Add support for traffic source attachment ([#248](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/248)) ([4dd59af](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/4dd59af3d61719493b4f33f89f5fba17471ff8ae))

## [7.1.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v7.0.0...v7.1.0) (2023-10-11)


### Features

* Instance refresh preferences ([#245](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/245)) ([f3ffe36](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/f3ffe3651bc0f358378bc53564016937a94b4d3d))

## [7.0.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.10.0...v7.0.0) (2023-10-09)


### ⚠ BREAKING CHANGES

* Use `launch_template_id` instead of `launch_template_name`, raise MSV of AWS provider and Terraform to 5.0 and 1.0 respectively (#204)

### Features

* Use `launch_template_id` instead of `launch_template_name`, raise MSV of AWS provider and Terraform to 5.0 and 1.0 respectively ([#204](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/204)) ([1d988c0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/1d988c0c218143c73369b016c2999d769cc0933d))

## [6.10.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.9.0...v6.10.0) (2023-05-17)


### Features

* Add auto_rollback feature to this module in instance_refresh settings ([#232](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/232)) ([f6adff7](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/f6adff7443da91db8eae5b3c16ad048d6eec9a13))

## [6.9.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.8.0...v6.9.0) (2023-03-06)


### Features

* Metric math support for target tracking scaling policy ([#225](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/225)) ([f9e0186](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/f9e0186c8d8cbc0398ba49b68ec7a5388b765ea3))

## [6.8.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.7.1...v6.8.0) (2023-03-06)


### Features

* Support `desired_capacity_type` and add mixed instance launch template override `instance_requirements` for ASG ([#220](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/220)) ([e867c0f](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/e867c0fa7b8cf87d2c9e6b4cb05a0b540c598ebe))

### [6.7.1](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.7.0...v6.7.1) (2023-01-24)


### Bug Fixes

* Use a version for  to avoid GitHub API rate limiting on CI workflows ([#219](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/219)) ([e4ac559](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/e4ac55948cd2e6895ed41d859b6e91119761a12c))

## [6.7.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.6.0...v6.7.0) (2022-12-15)


### Features

* Add support for `default_instance_warmup` argument ([#213](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/213)) ([e3e8ef0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/e3e8ef0a7a3140c7c0cdf0df54a24abab0714f22))

## [6.6.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.5.3...v6.6.0) (2022-12-15)


### Features

* Add support for `disable_api_stop` ([#218](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/218)) ([69415ea](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/69415ea56d6f16e1fbce3a81df231f858b2ecd3b))

### [6.5.3](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.5.2...v6.5.3) (2022-10-27)


### Bug Fixes

* Update CI configuration files to use latest version ([#209](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/209)) ([a1e9d9d](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/a1e9d9d74853741b34d980f8749835f73565e8c0))

### [6.5.2](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.5.1...v6.5.2) (2022-08-17)


### Bug Fixes

* Correct type constraint of `warm_pool` variable ([#203](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/203)) ([c071c7f](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/c071c7f6f77e8d26b4922d4814e2d6d725a88d23))

### [6.5.1](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.5.0...v6.5.1) (2022-06-21)


### Bug Fixes

* Updating license_specification block to be correct ([#196](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/196)) ([07887ea](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/07887ea824902b7295c4b5981da511d29b5fa9f8))

## [6.5.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.4.0...v6.5.0) (2022-06-03)


### Features

* Add support for IAM role and isntance profile creation ([#194](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/194)) ([2a9983f](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/2a9983f3a86fec4e4abce02f289ef58056c13494))

## [6.4.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.3.0...v6.4.0) (2022-05-16)


### Features

* Add support for ASG `maintenance_options` and LT `instance_requirements` ([#193](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/193)) ([1d1d3c0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/1d1d3c0c3bbcd069e362ba1131b111fbd5b5d906))

## [6.3.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.2.0...v6.3.0) (2022-04-05)


### Features

* Add outputs for launch template name and default version ([#191](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/191)) ([e329ad4](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/e329ad4e97bb6470cf18d1c48463ffdb7669f84c))

## [6.2.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.1.0...v6.2.0) (2022-04-04)


### Features

* Add separate autoscaling group tag variable, correct variable name for `availability_zones` to match resource spec ([#189](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/189)) ([a7e5746](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/a7e57469d5be62f9ee7cdf74a7acf627897b4f52))

## [6.1.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v6.0.0...v6.1.0) (2022-04-03)


### Features

* Improved support for EFA network interfaces ([#188](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/188)) ([f9f06ae](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/f9f06aea4e392ff6675543bb10256e161dab6666))

## [6.0.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v5.2.0...v6.0.0) (2022-04-03)


### ⚠ BREAKING CHANGES

* Update provider to `v4.x`, add new attributes from `v4.x`, change `user_data_base64` to `user_data` (#186)

### Features

* Update provider to `v4.x`, add new attributes from `v4.x`, change `user_data_base64` to `user_data` ([#186](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/186)) ([8e2e285](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/8e2e285b031faafe298de5d1d738e9743e607b3d))

## [5.2.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v5.1.1...v5.2.0) (2022-03-12)


### Features

* Made it clear that we stand with Ukraine ([eecd4f8](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/eecd4f83690256dc347a26b2c712daa035ede7bd))

### [5.1.1](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v5.1.0...v5.1.1) (2022-02-15)


### Bug Fixes

* Update syntax to be more concise using `try()` to replace verbose lookups to see if a value is provided or not ([#180](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/180)) ([4cf8df1](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/4cf8df15b51b3b7c63d9405168fda1b022789325))

## [5.1.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v5.0.0...v5.1.0) (2022-02-14)


### Features

* Remove launch configuration support, add support for ignoring `desired_capacity` ([#173](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/173)) ([300379d](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/300379dda611504d78be058d56b132c2baaa1157))

## [5.0.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.11.0...v5.0.0) (2022-02-14)


### ⚠ BREAKING CHANGES

* Update autoscaling group `tags` -> `tag` to support v4 of AWS provider (#179)

### Features

* Update autoscaling group `tags` -> `tag` to support v4 of AWS provider ([#179](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/179)) ([2c2a8a9](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/2c2a8a9bc255b49dc63f587d090b6b5a7d8b7c94))

## [4.11.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.10.0...v4.11.0) (2022-01-17)


### Features

* Add support for aws_autoscaling_policy ([#175](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/175)) ([a8ba844](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/a8ba844aee63309664c6cbaac582d26ce77fd655))

## [4.10.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.9.0...v4.10.0) (2022-01-14)


### Features

* Add `instance_metadata_tags` attribute to launch temlplate and bump AWS provider to support ([#176](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/176)) ([4019026](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/40190265ef651ef89d5e7a98dcf303a4757f40cd))

# [4.9.0](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.8.1...v4.9.0) (2021-11-22)


### Features

* add missing attributes to launch template, remove null resource for tag propagation, propagate default tags to instances, allow propagated name to be set independently of ASG ([#169](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/169)) ([f14ca13](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/f14ca13e28c1af150d65a7cd6f9d35d0863e33ae))

## [4.8.1](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.8.0...v4.8.1) (2021-11-15)


### Bug Fixes

* update CI/CD process to enable auto-release workflow ([#168](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/168)) ([d0338a8](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/commit/d0338a8163c239a404d72bf9c57377b0eca62f68))

<a name="v4.8.0"></a>
## [v4.8.0] - 2021-11-15

- feat: add checkpoint_delay, checkpoint_percent to instance refresh ([#166](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/166))
- docs: Fixed max_instance_lifetime min value in description ([#165](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/165))


<a name="v4.7.0"></a>
## [v4.7.0] - 2021-10-08

- feat: Add support of time_zone inside schedules ([#164](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/164))


<a name="v4.6.0"></a>
## [v4.6.0] - 2021-09-02

- feat: Add support for `warm_pool` ([#142](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/142))
- docs: Updated description of user_data and user_data_base64 ([#161](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/161))


<a name="v4.5.0"></a>
## [v4.5.0] - 2021-08-25

- feat: Added throughput parameter for root and ebs block devices ([#160](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/160))


<a name="v4.4.0"></a>
## [v4.4.0] - 2021-06-12

- feat: Control propagation of the ASG Name tag to instances ([#152](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/152))


<a name="v4.3.0"></a>
## [v4.3.0] - 2021-06-11

- fix: Fix instance refresh ([#151](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/151))


<a name="v4.2.0"></a>
## [v4.2.0] - 2021-06-02

- feat: Adding autoscaling schedule ([#150](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/150))
- chore: update CI/CD to use stable `terraform-docs` release artifact and discoverable Apache2.0 license ([#146](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/146))
- chore: Updated versions&comments in examples ([#145](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/145))


<a name="v4.1.0"></a>
## [v4.1.0] - 2021-04-08

- fix: add tags to launch template ([#141](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/141))


<a name="v4.0.0"></a>
## [v4.0.0] - 2021-04-08

- feat: update module to include launch template support, mixed instances policy, instance refresh, etc. ([#139](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/139))
- chore: update documentation and pin `terraform_docs` version to avoid future changes ([#138](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/138))
- chore: align ci-cd static checks to use individual minimum Terraform versions ([#134](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/134))
- chore: only run validate check on min terraform version ([#133](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/133))
- chore: add ci-cd workflow for pre-commit checks ([#131](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/131))


<a name="v3.9.0"></a>
## [v3.9.0] - 2021-02-20

- chore: update documentation based on latest `terraform-docs` which includes module and resource sections ([#129](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/129))


<a name="v3.8.0"></a>
## [v3.8.0] - 2020-11-24

- fix: Updated supported Terraform versions ([#123](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/123))


<a name="v3.7.0"></a>
## [v3.7.0] - 2020-10-06

- fix: conver to dynamic tags to allow for empty values ([#119](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/119))


<a name="v3.6.0"></a>
## [v3.6.0] - 2020-08-13

- feat: aws-provider version bump to >= 2.41, < 4.0 ([#115](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/115))
- feat: base64 encoded user_data ([#107](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/107))
- fix: Changed owner to amazon in examples ([#105](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/105))


<a name="v3.5.0"></a>
## [v3.5.0] - 2020-04-10

- feat: Added max_instance_lifetime option for Auto Scaling Group ([#98](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/98))
- Updated aws_ec2 example with service_linked_role_arn
- Adds service_linked_role ([#77](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/77))
- Updated pre-commit hooks
- added encrypted option to root_block_device ([#78](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/78))
- Updated pre-commit hooks
- Fixed example (health_check to map of strings) ([#73](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/73))
- Update for Terraform 0.12 ([#68](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/68))


<a name="v2.12.0"></a>
## [v2.12.0] - 2019-11-08

- Added support for service_linked_role_arn (based on [#70](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/70))
- Corrected create launch configuration flag


<a name="v3.4.0"></a>
## [v3.4.0] - 2019-11-08

- Updated aws_ec2 example with service_linked_role_arn


<a name="v3.3.0"></a>
## [v3.3.0] - 2019-11-08

- Adds service_linked_role ([#77](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/77))


<a name="v3.2.0"></a>
## [v3.2.0] - 2019-11-08

- Updated pre-commit hooks
- added encrypted option to root_block_device ([#78](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/78))


<a name="v3.1.0"></a>
## [v3.1.0] - 2019-08-21

- Updated pre-commit hooks
- Fixed example (health_check to map of strings) ([#73](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/73))
- Update for Terraform 0.12 ([#68](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/68))


<a name="v2.11.0"></a>
## [v2.11.0] - 2019-06-08

- Corrected create launch configuration flag


<a name="v3.0.0"></a>
## [v3.0.0] - 2019-06-08

- Update for Terraform 0.12 ([#68](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/68))


<a name="v2.10.0"></a>
## [v2.10.0] - 2019-06-08



<a name="v2.9.1"></a>
## [v2.9.1] - 2019-01-01

- Fixed typo (closes [#49](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/49))


<a name="v2.9.0"></a>
## [v2.9.0] - 2018-11-23

- Added conditional for initial_lifecycle_hook parameter ([#52](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/52))
- Minor cleanup after [#45](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/45)


<a name="v2.8.0"></a>
## [v2.8.0] - 2018-08-18

- Fix to support externally created launch configurations (fix [#43](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/43)) ([#45](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/45))


<a name="v2.7.0"></a>
## [v2.7.0] - 2018-06-20

- Allow recreation of ASG when LC changes (fixes [#34](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/34)) ([#36](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/36))


<a name="v2.6.0"></a>
## [v2.6.0] - 2018-06-03

- Add lifecycle hooks create_before_destroy to the autoscaling group ([#33](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/33))


<a name="v2.5.1"></a>
## [v2.5.1] - 2018-05-16

- Updated headers in README.md


<a name="v2.5.0"></a>
## [v2.5.0] - 2018-05-16

- Added pre-commit hook to autogenerate terraform-docs ([#32](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/32))


<a name="v2.4.0"></a>
## [v2.4.0] - 2018-05-16

- Allow unlimited tags in ASG ([#31](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/31))


<a name="v2.3.0"></a>
## [v2.3.0] - 2018-04-23

- Enable spot_price on launch configuration ([#26](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/26))


<a name="v2.2.2"></a>
## [v2.2.2] - 2018-04-09

- Set default user_data to single char ([#24](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/24))


<a name="v2.2.1"></a>
## [v2.2.1] - 2018-03-15

- Fixed tags as maps bug ([#22](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/22))


<a name="v2.2.0"></a>
## [v2.2.0] - 2018-03-14

- Added readme about tags, updated example
- ref [#12](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/12) [#1](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/1) - resolve tagging format difference ([#19](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/19))


<a name="v2.1.0"></a>
## [v2.1.0] - 2018-01-11

- Launch configuration naming, tagging fix/clarity ([#11](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/11))
- Describe tag format ([#12](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/12))


<a name="v2.0.0"></a>
## [v2.0.0] - 2017-11-28

- Merge ASG and LC submodules into one, added conditional creation ([#10](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/10))


<a name="v1.2.0"></a>
## [v1.2.0] - 2017-11-26

- comment out output for target group arns ([#9](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/9))


<a name="v1.1.0"></a>
## [v1.1.0] - 2017-11-24

- Removed output of target_group_arns (closes [#7](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/7))


<a name="v1.0.4"></a>
## [v1.0.4] - 2017-11-22

- Disable output of load_balancers, because they are not always present


<a name="v1.0.3"></a>
## [v1.0.3] - 2017-10-04

- target_group_arns should be a list (workaround for issue: https://github.com/hashicorp/terraform/issues/13869)
- target_group_arns should be a list (workaround for issue: https://github.com/hashicorp/terraform/issues/13869)


<a name="v1.0.2"></a>
## [v1.0.2] - 2017-09-26

- Added ASG with ELB example


<a name="v1.0.1"></a>
## [v1.0.1] - 2017-09-26

- TF: Correct list all the way down
- TF: Fix passing list from main to ASG submodule


<a name="v1.0.0"></a>
## v1.0.0 - 2017-09-14

- Added all code and README
- Initial commit


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.8.0...HEAD
[v4.8.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.7.0...v4.8.0
[v4.7.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.6.0...v4.7.0
[v4.6.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.5.0...v4.6.0
[v4.5.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.4.0...v4.5.0
[v4.4.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.3.0...v4.4.0
[v4.3.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.2.0...v4.3.0
[v4.2.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.1.0...v4.2.0
[v4.1.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v4.0.0...v4.1.0
[v4.0.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v3.9.0...v4.0.0
[v3.9.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v3.8.0...v3.9.0
[v3.8.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v3.7.0...v3.8.0
[v3.7.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v3.6.0...v3.7.0
[v3.6.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v3.5.0...v3.6.0
[v3.5.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.12.0...v3.5.0
[v2.12.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v3.4.0...v2.12.0
[v3.4.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v3.3.0...v3.4.0
[v3.3.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v3.2.0...v3.3.0
[v3.2.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v3.1.0...v3.2.0
[v3.1.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.11.0...v3.1.0
[v2.11.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v3.0.0...v2.11.0
[v3.0.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.10.0...v3.0.0
[v2.10.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.9.1...v2.10.0
[v2.9.1]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.9.0...v2.9.1
[v2.9.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.8.0...v2.9.0
[v2.8.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.7.0...v2.8.0
[v2.7.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.6.0...v2.7.0
[v2.6.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.5.1...v2.6.0
[v2.5.1]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.5.0...v2.5.1
[v2.5.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.4.0...v2.5.0
[v2.4.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.3.0...v2.4.0
[v2.3.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.2.2...v2.3.0
[v2.2.2]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.2.1...v2.2.2
[v2.2.1]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.2.0...v2.2.1
[v2.2.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.1.0...v2.2.0
[v2.1.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.0.0...v2.1.0
[v2.0.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v1.2.0...v2.0.0
[v1.2.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v1.1.0...v1.2.0
[v1.1.0]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v1.0.4...v1.1.0
[v1.0.4]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v1.0.3...v1.0.4
[v1.0.3]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v1.0.2...v1.0.3
[v1.0.2]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v1.0.1...v1.0.2
[v1.0.1]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v1.0.0...v1.0.1
