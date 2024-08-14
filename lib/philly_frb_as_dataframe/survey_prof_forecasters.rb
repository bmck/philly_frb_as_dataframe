require 'polars-df'
require 'httparty'
require 'roo'
require 'csv'

module PhillyFrbAsDataframe
  class SurveyProfForecasters

    include ::HTTParty

    attr_reader :ary

    def initialize
    end

    def fetch(start: nil, fin: nil)
      dat = _fetch_data.dup
      hsh = dat.map{|d| d.map{|r| r.to_hash }.each{|h|  h['Timestamps_'] = Date.new(h['YEAR'], (3*(h['QUARTER'])-2), 1) } }
      df = nil

      hsh.each do |h| 
        keys = h.first.keys
        vals = h.map(&:values).transpose

        tmp_df = {}; (0..(keys.length-1)).to_a.each{|i| tmp_df[keys[i]] = vals[i]}

        tmp_df = Polars::DataFrame.new(tmp_df).drop(['QUARTER', 'YEAR'])
        tmp_df = tmp_df.filter(Polars.col('Timestamps_') <= fin.to_date) unless start.nil?
        tmp_df = tmp_df.filter(Polars.col('Timestamps_') >= start.to_date) unless fin.nil?

        if h == hsh.first
          df = tmp_df
        else
          df = df.join(tmp_df, on: 'Timestamps_', how: 'full').drop(['Timestamps__right'])
        end

      end
      s = Polars::Series.new('Timestamps', df['Timestamps_'].to_a)
      df = df.insert_column(0,s).drop(['Timestamps_'])

      df
    end

    protected

    private

    def _fetch_data #(options={})
      xlsx_dta = self.class.get('https://www.philadelphiafed.org/-/media/frbp/assets/surveys-and-data/survey-of-professional-forecasters/historical-data/meanlevel.xlsx').parsed_response
      csv_dta = []

      na_converter = proc {|field| field == '#N/A' ? nil : field }
      CSV::Converters[:na] = na_converter

      Tempfile.open(['foo', '.xlsx'], '/tmp', binmode: true) do |f|
        f.write(xlsx_dta)
        f.rewind
        xlsx_file = Roo::Excelx.new(f.path)
        xlsx_file.each_with_pagename do |name, sheet|
          csv_dta << CSV.parse(sheet.to_csv, headers: true, converters: [:numeric, :na], nil_value: '\"#N/A\"')
        end
      end
      csv_dta.map{|dta| dta[0..-1]}
    end
  end
end
