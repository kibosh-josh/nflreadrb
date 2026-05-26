# frozen_string_literal: true

module Nflreadrb
  # Loads depth chart data for a given year. Columns filtering can be added to return only a subset of data
  class DepthCharts < BaseLoader
    def initialize(year:, columns:)
      super
      @url = "#{Constants::BASE_URL}/depth_charts/depth_charts_#{year}.parquet"
      @dataset_includes_season = false
    end
    private_class_method :new
  end

  private_constant :DepthCharts
end
