# frozen_string_literal: true

module Nflreadrb
  # Loads player stats data for a given year. Columns filtering can be added to return only a subset of data
  class PlayerStats < BaseLoader
    def initialize(year:, columns:)
      super
      @url = "#{Constants::BASE_URL}/stats_player/stats_player_week_#{year}.parquet"
    end
    private_class_method :new
  end

  private_constant :PlayerStats
end
