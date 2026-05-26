# frozen_string_literal: true

module Nflreadrb
  # Loads weekly roster data for a given year. Columns filtering can be added to return only a subset of data
  class WeeklyRosters < BaseLoader
    def initialize(year:, columns:)
      super
      @url = "#{Constants::BASE_URL}/weekly_rosters/roster_weekly_#{year}.parquet"
    end
    private_class_method :new
  end

  private_constant :WeeklyRosters
end
