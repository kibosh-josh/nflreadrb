# frozen_string_literal: true

module Nflreadrb
  module ParquetLoader
    class << self
      # We always filter results by year for stats, to keep the result set focused and somewhat limited. That column is called 'season'.
      FILTER_COL = 'season'

      def fetch_and_filter(url:, year:, columns: nil)
        Tempfile.create(['nflreadrb', '.parquet']) do |temp_file|
          temp_file.binmode
          URI.open(url) { |remote_file| temp_file.write(remote_file.read) }
          temp_file.rewind

          requested_columns = columns&.map(&:to_s)
          dataframe = Polars.read_parquet(temp_file.path, columns: download_columns_from(requested_columns))
          # 1. Filter vertically by season
          filtered_dataframe = dataframe.filter(Polars.col(FILTER_COL) == year.to_i)

          # 2. Filter horizontally to return only what columns are requested
          filtered_dataframe = filtered_dataframe.select(requested_columns) if requested_columns

          filtered_dataframe.to_a
        end
      rescue OpenURI::HTTPError => e
        raise Error, "Failed to fetch data from url: #{url}: #{e.message}"
      end

      private

      def download_columns_from(requested_columns)
        return nil if requested_columns.nil?

        ([FILTER_COL] + requested_columns).uniq
      end
    end
  end

  private_constant :ParquetLoader
end