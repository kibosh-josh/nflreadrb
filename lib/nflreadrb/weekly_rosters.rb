# frozen_string_literal: true

module Nflreadrb
  class WeeklyRosters < BaseLoader
    def initialize(year:, columns:)
      super(year:, columns:)
      @url = "#{Constants::BASE_URL}/weekly_rosters/roster_weekly_#{year}.parquet"
    end
    private_class_method :new
  end

  private_constant :WeeklyRosters
end
