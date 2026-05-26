# frozen_string_literal: true

require_relative 'constants'
require_relative 'parquet_loader'

module Nflreadrb
  class BaseLoader
    def initialize(year:, columns:)
      @year = year
      @columns = columns
      @dataset_includes_season = true
    end
    private_class_method :new

    def self.load(year:, columns: nil)
      new(year:, columns:).load_data
    end

    def load_data
      ParquetLoader.fetch_and_filter(url:, year:, columns:, dataset_includes_season:)
    end

    private

    attr_reader :year, :url, :columns, :dataset_includes_season
  end

  private_constant :BaseLoader
end