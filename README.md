# PhillyFrbAsDataframe

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/philly_frb_as_dataframe`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'philly_frb_as_dataframe'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install philly_frb_as_dataframe

## Usage

```{ruby}
3.1.2 :001 > PhillyFrbAsDataframe::PartisanConflict.new.fetch
 => 
shape: (522, 2)                                                               
┌────────────┬───────────────────┐                                            
│ Timestamps ┆ Partisan Conflict │                                            
│ ---        ┆ ---               │                                            
│ date       ┆ f64               │                                            
╞════════════╪═══════════════════╡                                            
│ 1981-01-01 ┆ 68.944808         │                                            
│ 1981-02-01 ┆ 64.907109         │                                            
│ 1981-03-01 ┆ 79.058476         │
│ 1981-04-01 ┆ 69.324041         │
│ 1981-05-01 ┆ 88.194466         │
│ …          ┆ …                 │
│ 2024-02-01 ┆ 131.52            │
│ 2024-03-01 ┆ 141.55            │
│ 2024-04-01 ┆ 119.98            │
│ 2024-05-01 ┆ 113.41            │
│ 2024-06-01 ┆ 103.95            │
└────────────┴───────────────────┘ 
3.1.2 :002 > PhillyFrbAsDataframe::PartisanConflict.new.fetch(start: Date.new(2000,01,01), fin: Date.new(2020,12,31))
 => 
shape: (252, 2)                                                               
┌────────────┬───────────────────┐                                            
│ Timestamps ┆ Partisan Conflict │                                            
│ ---        ┆ ---               │                                            
│ date       ┆ f64               │                                            
╞════════════╪═══════════════════╡                                            
│ 2000-01-01 ┆ 77.280948         │                                            
│ 2000-02-01 ┆ 86.638723         │                                            
│ 2000-03-01 ┆ 94.667911         │
│ 2000-04-01 ┆ 80.756581         │
│ 2000-05-01 ┆ 79.505339         │
│ …          ┆ …                 │
│ 2020-08-01 ┆ 98.07             │
│ 2020-09-01 ┆ 116.31            │
│ 2020-10-01 ┆ 137.03            │
│ 2020-11-01 ┆ 156.84            │
│ 2020-12-01 ┆ 117.87            │
└────────────┴───────────────────┘ 
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/philly_frb_as_dataframe. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/philly_frb_as_dataframe/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PhillyFrbAsDataframe project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/philly_frb_as_dataframe/blob/main/CODE_OF_CONDUCT.md).
