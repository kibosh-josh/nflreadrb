# frozen_string_literal: true

require_relative 'constants'

module Nflreadrb
  class WeeklyRosters
    class << self
      def load(year:)
        url = roster_url(year)
        ParquetLoader.fetch_and_filter(url:, year:)
      end

      private

      def roster_url(year)
        "#{Constants::BASE_URL}/weekly_rosters/roster_weekly_#{year}.parquet"
      end
    end
  end

  private_constant :WeeklyRosters
end