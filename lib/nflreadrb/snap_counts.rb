# frozen_string_literal: true

module Nflreadrb
  class SnapCounts < BaseLoader
    def initialize(year:, columns:)
      super(year:, columns:)
      @url = "#{Constants::BASE_URL}/snap_counts/snap_counts_#{year}.parquet"
    end
    private_class_method :new
  end

  private_constant :SnapCounts
end