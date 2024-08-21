require 'polars-df'
require 'httparty'
require 'roo'
require 'csv'

module PhillyFrbAsDataframe
  class PartisanConflict

    include ::HTTParty

    attr_reader :ary

    def initialize
    end

    def fetch(start: nil, fin: nil)
      dat = _fetch_data.dup
      hsh = dat.map{|r| r.to_hash }.each{|h| h['Timestamps_'] = DateTime.strptime("#{h['Month']} 01 #{h['Year']}", '%B %d %Y').to_date }
      keys = hsh.first.keys
      vals = hsh.map(&:values).transpose

      df = {}; (0..(keys.length-1)).to_a.each{|i| df[keys[i]] = vals[i]}

      df = Polars::DataFrame.new(df)
      df = df.filter(Polars.col('Timestamps_') <= fin.to_date) unless fin.nil?
      df = df.filter(Polars.col('Timestamps_') >= start.to_date) unless start.nil?
      s = Polars::Series.new('Timestamps', df['Timestamps_'].to_a)
      df = df.insert_column(0,s).drop(['Month', 'Year', 'Timestamps_'])

      df
    end

    protected

    private

    def _fetch_data #(options={})
      xlsx_dta = self.class.get('https://www.philadelphiafed.org/-/media/frbp/assets/data-visualizations/partisan-conflict.xlsx').parsed_response
      csv_dta = nil
      Tempfile.open(['foo', '.xlsx'], '/tmp', binmode: true) do |f|
         f.write(xlsx_dta)
         f.rewind
         csv_dta = CSV.parse(Roo::Excelx.new(f.path).to_csv, headers: true, converters: :numeric)
      end
      csv_dta[0..-1]
    end
  end
end
