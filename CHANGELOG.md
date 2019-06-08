<a name="unreleased"></a>
## [Unreleased]



<a name="v2.10.0"></a>
## [v2.10.0] - 0001-01-01



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

- Merge pull request [#5](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/5) from kospant/master
- target_group_arns should be a list (workaround for issue: https://github.com/hashicorp/terraform/issues/13869)
- target_group_arns should be a list (workaround for issue: https://github.com/hashicorp/terraform/issues/13869)


<a name="v1.0.2"></a>
## [v1.0.2] - 2017-09-26

- Added ASG with ELB example


<a name="v1.0.1"></a>
## [v1.0.1] - 2017-09-26

- Merge pull request [#2](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/issues/2) from thanandorn/bugfix/lb_list_type
- TF: Correct list all the way down
- TF: Fix passing list from main to ASG submodule


<a name="v1.0.0"></a>
## v1.0.0 - 2017-09-14

- Added all code and README
- Initial commit


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-autoscaling/compare/v2.10.0...HEAD
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
