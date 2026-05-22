# frozen_string_literal: true

require_relative 'constants'
require_relative 'parquet_loader'

module Nflreadrb
  class Injuries
    class << self
      def load(year:)
        url = injuries_url(year:)
        ParquetLoader.fetch_and_filter(url:, year:)
      end

      private

      def injuries_url(year:)
        "#{Constants::BASE_URL}/injuries/injuries_#{year}.parquet"
      end
    end
  end

  private_constant :Injuries
end