# frozen_string_literal: true

require_relative 'constants'
require_relative 'parquet_loader'

module Nflreadrb
  class SnapCounts
    class << self
      def load(year:)
        url = snap_counts_url(year)
        ParquetLoader.fetch_and_filter(url:, year:)
      end

      private

      def snap_counts_url(year)
        "#{Constants::BASE_URL}/snap_counts/snap_counts_#{year}.parquet"
      end
    end
  end

  private_constant :SnapCounts
end