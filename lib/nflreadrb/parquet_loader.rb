# frozen_string_literal: true

module Nflreadrb
  module ParquetLoader
    class << self
      DEFAULT_COLUMN = 'season'

      def fetch_and_filter(url:, year:, column_name: DEFAULT_COLUMN)
        Tempfile.create(['nflreadrb', '.parquet']) do |temp_file|
          temp_file.binmode
          URI.open(url) { |remote_file| temp_file.write(remote_file.read) }
          temp_file.rewind

          dataframe = Polars.read_parquet(temp_file.path)
          dataframe.filter(Polars.col(column_name) == year.to_i).to_a
        end
      rescue OpenURI::HTTPError => e
        raise Error, "Failed to fetch data from url: #{url}: #{e.message}"
      end
    end
  end

  private_constant :ParquetLoader
end