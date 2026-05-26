# frozen_string_literal: true

require_relative 'local_cache'

module Nflreadrb
  class ParquetLoader
    SEASON_FILTER = 'season'

    def self.fetch_and_filter(year:, url:, columns: nil, dataset_includes_season: true)
      new(year:, url:, columns:, dataset_includes_season:).fetch_and_filter
    end

    def initialize(year:, url:, columns:, dataset_includes_season:)
      @year = year.to_i
      @url = url
      @columns = columns&.map(&:to_s)
      @dataset_includes_season = dataset_includes_season
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
      return columns.uniq unless dataset_includes_season

      ([SEASON_FILTER] + columns).uniq
    end

    def filtered_dataframe_from(dataframe, columns)
      # 3a. Filter vertically by season. Some data frames do not include a season filter, they are already filtered by season.
      filtered_dataframe = filter_dataframe_vertically(dataframe)

      return filtered_dataframe.to_a if columns.nil?

      # 3b. Filter horizontally to isolate user-requested columns if present
      filtered_dataframe.select(columns).to_a
    end

    def filter_dataframe_vertically(dataframe)
      # For data sets like depth charts, this has already been filtered upstream by season/year.
      return dataframe unless dataset_includes_season

      dataframe.filter(Polars.col(SEASON_FILTER) == year)
    end


    attr_reader :year, :url, :columns, :dataset_includes_season
  end

  private_constant :ParquetLoader
end