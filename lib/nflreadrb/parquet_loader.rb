# frozen_string_literal: true

require_relative 'local_cache'

module Nflreadrb
  class ParquetLoader
    SEASON_FILTER = 'season'

    def self.fetch_and_filter(year:, url:, columns: nil)
      new(year:, url:, columns:).fetch_and_filter
    end

    def initialize(year:, url:, columns:)
      @year = year.to_i
      @url = url
      @columns = columns&.map(&:to_s)
    end
    private_class_method :new

    def fetch_and_filter
      # 1. Delegate the file retrieval entirely to the cache manager
      local_path = LocalCache.path_for(url)

      # 2. Execute the Polars data transformation operations natively
      dataframe = Polars.read_parquet(local_path, columns: download_columns_from(columns))

      # 3. Filter results
      filtered_dataframe_from(dataframe, columns)
    end

    private

    def download_columns_from(columns)
      return nil if columns.nil?

      ([SEASON_FILTER] + columns).uniq
    end

    def filtered_dataframe_from(dataframe, columns)
      # 3a. Filter vertically by season
      filtered_dataframe = dataframe.filter(Polars.col(SEASON_FILTER) == year)

      return filtered_dataframe.to_a if columns.nil?

      # 3b. Filter horizontally to isolate user-requested columns if present
      filtered_dataframe.select(columns).to_a
    end

    attr_reader :year, :url, :columns
  end

  private_constant :ParquetLoader
end