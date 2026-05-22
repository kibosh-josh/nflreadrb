# frozen_string_literal: true

require_relative 'local_cache'

module Nflreadrb
  module ParquetLoader
    class << self
      FILTER_COL = 'season'

      def fetch_and_filter(url:, year:, columns: nil)
        # 1. Delegate the file retrieval entirely to the cache manager
        local_path = LocalCache.path_for(url)

        # 2. Execute the Polars data transformation operations natively
        requested_columns = columns&.map(&:to_s)
        dataframe = Polars.read_parquet(local_path, columns: download_columns_from(requested_columns))

        # 3. Filter vertically by season
        filtered_dataframe = dataframe.filter(Polars.col(FILTER_COL) == year.to_i)

        # 4. Filter horizontally to isolate user-requested columns if present
        filtered_dataframe = filtered_dataframe.select(requested_columns) if requested_columns

        filtered_dataframe.to_a
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