# frozen_string_literal: true

module Nflreadrb
  class DepthCharts < BaseLoader
    def initialize(year:, columns:)
      super(year:, columns:)
      @url = "#{Constants::BASE_URL}/depth_charts/depth_charts_#{year}.parquet"
      @dataset_includes_season = false
    end
    private_class_method :new
  end

  private_constant :DepthCharts
end
