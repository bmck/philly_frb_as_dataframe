# frozen_string_literal: true

require 'set'
require 'bundler/setup'
require_relative '../lib/philly_frb_as_dataframe'

failures = []
failures << 'version' if PhillyFrbAsDataframe::VERSION.to_s.empty?
pc = PhillyFrbAsDataframe::PartisanConflict.new
spf = PhillyFrbAsDataframe::SurveyProfForecasters.new
failures << 'partisan' unless pc.is_a?(PhillyFrbAsDataframe::PartisanConflict) && pc.respond_to?(:fetch)
failures << 'spf' unless spf.is_a?(PhillyFrbAsDataframe::SurveyProfForecasters) && spf.respond_to?(:fetch)

if failures.empty?
  puts 'test_philly: ok'
else
  abort "test_philly failed: #{failures.join(', ')}"
end
