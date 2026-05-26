# frozen_string_literal: true

module Nflreadrb
  # Loads snap count data for a given year. Columns filtering can be added to return only a subset of data
  class SnapCounts < BaseLoader
    def initialize(year:, columns:)
      super
      @url = "#{Constants::BASE_URL}/snap_counts/snap_counts_#{year}.parquet"
    end
    private_class_method :new
  end

  private_constant :SnapCounts
end
