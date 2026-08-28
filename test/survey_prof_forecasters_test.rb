# frozen_string_literal: true

require "test_helper"

class SurveyProfForecastersTest < Minitest::Test
  def setup
    @fixture_path = File.expand_path("fixtures/survey_prof_forecasters.xlsx", __dir__)
    @fixture_data = File.binread(@fixture_path)
    @url = "https://www.philadelphiafed.org/-/media/frbp/assets/surveys-and-data/survey-of-professional-forecasters/historical-data/meanlevel.xlsx"
  end

  def test_fetch_returns_dataframe
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    spf = PhillyFrbAsDataframe::SurveyProfForecasters.new
    result = spf.fetch

    assert_instance_of Polars::DataFrame, result
  end

  def test_fetch_has_timestamps_column
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    spf = PhillyFrbAsDataframe::SurveyProfForecasters.new
    result = spf.fetch

    assert_includes result.columns, "Timestamps"
    refute_includes result.columns, "QUARTER"
    refute_includes result.columns, "YEAR"
  end

  def test_fetch_has_ngdp_columns
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    spf = PhillyFrbAsDataframe::SurveyProfForecasters.new
    result = spf.fetch

    assert_includes result.columns, "NGDP1"
    assert_includes result.columns, "NGDP2"
  end

  def test_fetch_has_pgdp_columns
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    spf = PhillyFrbAsDataframe::SurveyProfForecasters.new
    result = spf.fetch

    assert_includes result.columns, "PGDP1"
    assert_includes result.columns, "PGDP2"
  end

  def test_fetch_correct_row_count
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    spf = PhillyFrbAsDataframe::SurveyProfForecasters.new
    result = spf.fetch

    assert_equal 2, result.height
  end

  def test_fetch_timestamps_are_dates
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    spf = PhillyFrbAsDataframe::SurveyProfForecasters.new
    result = spf.fetch

    timestamps = result["Timestamps"].to_a
    assert_equal 2, timestamps.length
    assert_instance_of Date, timestamps.first
  end

  def test_fetch_with_date_filter_start
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    spf = PhillyFrbAsDataframe::SurveyProfForecasters.new
    result = spf.fetch(start: Date.new(2020, 4, 1))

    assert_equal 1, result.height
  end

  def test_fetch_with_date_filter_fin
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    spf = PhillyFrbAsDataframe::SurveyProfForecasters.new
    result = spf.fetch(fin: Date.new(2020, 1, 1))

    assert_equal 1, result.height
  end

  def test_fetch_with_date_filter_both
    stub_request(:get, @url).to_return(status: 200, body: @fixture_data)

    spf = PhillyFrbAsDataframe::SurveyProfForecasters.new
    result = spf.fetch(start: Date.new(2020, 1, 1), fin: Date.new(2020, 3, 31))

    assert_equal 1, result.height
  end
end
