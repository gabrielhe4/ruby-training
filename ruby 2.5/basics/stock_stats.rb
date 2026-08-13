require_relative "csv_reader"   # to bring in the library it needs

reader = CsvReader.new()

ARGV.each do |csv_file_name|
  $stderr.puts "Reading #{csv_file_name}"
  reader.read_in_csv_data(csv_file_name)
end

# execute: ruby stock_stats.rb data.csv