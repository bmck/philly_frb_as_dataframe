# frozen_string_literal: true

require "test_helper"

class PartisanConflictTest < Minitest::Test
  def setup
    @fixture_path = File.expand_path("fixtures/partisan_conflict.xlsx", __dir__)
    @fixture_data = File.binread(@fixture_path)
    @url = "https://www.philadelphiafed.org/-/media/frbp/assets/data-visualizations/partisan-conflict.xlsx"
  end

  def test_fetch_returns_dataframe
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    pc = PhillyFrbAsDataframe::PartisanConflict.new
    result = pc.fetch

    assert_instance_of Polars::DataFrame, result
  end

  def test_fetch_has_correct_columns
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    pc = PhillyFrbAsDataframe::PartisanConflict.new
    result = pc.fetch

    assert_includes result.columns, "Timestamps"
    assert_includes result.columns, "Partisan Conflict"
    refute_includes result.columns, "Month"
    refute_includes result.columns, "Year"
  end

  def test_fetch_has_correct_shape
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    pc = PhillyFrbAsDataframe::PartisanConflict.new
    result = pc.fetch

    assert_equal 3, result.height
    assert_equal 2, result.width
  end

  def test_fetch_timestamps_column
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    pc = PhillyFrbAsDataframe::PartisanConflict.new
    result = pc.fetch

    timestamps = result["Timestamps"].to_a
    assert_equal 3, timestamps.length
    assert_instance_of Date, timestamps.first
  end

  def test_fetch_with_date_filter_start
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    pc = PhillyFrbAsDataframe::PartisanConflict.new
    result = pc.fetch(start: Date.new(2020, 2, 1))

    assert_equal 2, result.height
  end

  def test_fetch_with_date_filter_fin
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    pc = PhillyFrbAsDataframe::PartisanConflict.new
    result = pc.fetch(fin: Date.new(2020, 2, 1))

    assert_equal 2, result.height
  end

  def test_fetch_with_date_filter_both
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    pc = PhillyFrbAsDataframe::PartisanConflict.new
    result = pc.fetch(start: Date.new(2020, 2, 1), fin: Date.new(2020, 2, 28))

    assert_equal 1, result.height
  end
end
