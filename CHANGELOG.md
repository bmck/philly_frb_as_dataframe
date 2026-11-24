## [Unreleased]

- Pin development to Ruby 3.3.14. Ruby 3.3.6 is affected by the November 2026 regexp and string security advisories, which 3.3.14 fixes.
- Move the minitest development dependency from 5.x to 6.x. This gem requires Ruby >= 3.3, so it no longer needs the minitest 5 line kept for older Rubies.
- Point Travis at Ruby 3.3.14 and stop installing Bundler 2.2.33.

## [0.2.0] - 2026-08-28

- Updated required_ruby_version to >= 3.3
- Updated polars-df dependency to 0.27.1

## [0.1.0] - 2024-08-05

- Initial release
