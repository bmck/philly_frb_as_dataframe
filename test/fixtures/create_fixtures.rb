#!/usr/bin/env ruby
# frozen_string_literal: true

# This script creates minimal xlsx fixtures for testing
require 'bundler/setup'
require 'roo'
require 'csv'
require 'fileutils'

# Create partisan_conflict.xlsx fixture
def create_partisan_conflict_fixture
  csv_content = <<~CSV
    Month,Year,Partisan Conflict
    January,2020,100.5
    February,2020,105.3
    March,2020,110.2
  CSV
  
  # Create a temporary CSV file and convert to xlsx using system tools
  # For now, we'll use a simplified approach and create the xlsx manually
  # Since we're testing with webmock, we just need valid xlsx binary
  
  require 'tempfile'
  require 'write_xlsx'
  
  workbook = WriteXLSX.new('test/fixtures/partisan_conflict.xlsx')
  worksheet = workbook.add_worksheet
  
  # Write headers
  worksheet.write(0, 0, 'Month')
  worksheet.write(0, 1, 'Year')
  worksheet.write(0, 2, 'Partisan Conflict')
  
  # Write data rows
  worksheet.write(1, 0, 'January')
  worksheet.write(1, 1, 2020)
  worksheet.write(1, 2, 100.5)
  
  worksheet.write(2, 0, 'February')
  worksheet.write(2, 1, 2020)
  worksheet.write(2, 2, 105.3)
  
  worksheet.write(3, 0, 'March')
  worksheet.write(3, 1, 2020)
  worksheet.write(3, 2, 110.2)
  
  workbook.close
end

# Create survey_prof_forecasters.xlsx fixture
def create_survey_fixture
  require 'write_xlsx'
  
  workbook = WriteXLSX.new('test/fixtures/survey_prof_forecasters.xlsx')
  
  # Create first sheet
  worksheet1 = workbook.add_worksheet('Sheet1')
  worksheet1.write(0, 0, 'YEAR')
  worksheet1.write(0, 1, 'QUARTER')
  worksheet1.write(0, 2, 'NGDP1')
  worksheet1.write(0, 3, 'NGDP2')
  
  worksheet1.write(1, 0, 2020)
  worksheet1.write(1, 1, 1)
  worksheet1.write(1, 2, 25000.5)
  worksheet1.write(1, 3, 25100.3)
  
  worksheet1.write(2, 0, 2020)
  worksheet1.write(2, 1, 2)
  worksheet1.write(2, 2, 25200.1)
  worksheet1.write(2, 3, 25300.8)
  
  # Create second sheet
  worksheet2 = workbook.add_worksheet('Sheet2')
  worksheet2.write(0, 0, 'YEAR')
  worksheet2.write(0, 1, 'QUARTER')
  worksheet2.write(0, 2, 'PGDP1')
  worksheet2.write(0, 3, 'PGDP2')
  
  worksheet2.write(1, 0, 2020)
  worksheet2.write(1, 1, 1)
  worksheet2.write(1, 2, 120.5)
  worksheet2.write(1, 3, 121.3)
  
  worksheet2.write(2, 0, 2020)
  worksheet2.write(2, 1, 2)
  worksheet2.write(2, 2, 122.1)
  worksheet2.write(2, 3, 123.8)
  
  workbook.close
end

if __FILE__ == $0
  create_partisan_conflict_fixture
  create_survey_fixture
  puts "Fixtures created successfully!"
end
