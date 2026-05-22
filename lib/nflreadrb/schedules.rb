# frozen_string_literal: true

require_relative 'constants'
require_relative 'parquet_loader'

module Nflreadrb
  class Schedules
    class << self
      def load(year:)
        url = schedules_url
        ParquetLoader.fetch_and_filter(url:, year:)
      end

      private

      def schedules_url
        "#{Constants::BASE_URL}/schedules/games.parquet"
      end
    end
  end

  private_constant :Schedules
end