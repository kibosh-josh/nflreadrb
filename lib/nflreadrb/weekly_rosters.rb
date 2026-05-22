# frozen_string_literal: true

module Nflreadrb
  class WeeklyRosters < BaseLoader
    def initialize(year:)
      @year = year
      @url = "#{Constants::BASE_URL}/weekly_rosters/roster_weekly_#{year}.parquet"
    end
    private_class_method :new

    def self.load(year:)
      new(year:).load_data
    end
  end

  private_constant :WeeklyRosters
end