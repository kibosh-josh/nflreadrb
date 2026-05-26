# frozen_string_literal: true

module Nflreadrb
  class PlayerStats < BaseLoader
    def initialize(year:, columns:)
      super(year:, columns:)
      @url = "#{Constants::BASE_URL}/stats_player/stats_player_week_#{year}.parquet"
    end
    private_class_method :new
  end

  private_constant :PlayerStats
end
