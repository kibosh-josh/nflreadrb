# frozen_string_literal: true

require_relative 'constants'
require_relative 'parquet_loader'

module Nflreadrb
  class PlayerStats
    class << self
      def load(year:)
        ParquetLoader.fetch_and_filter(url: player_stats_url, year:)
      end

      private

      def player_stats_url
        "#{Constants::BASE_URL}/player_stats/player_stats.parquet"
      end
    end
  end

  private_constant :PlayerStats
end