# frozen_string_literal: true

module Nflreadrb
  class PlayerStats < BaseLoader
    def initialize(year:, columns:)
      super(year:, columns:)
      @url = "#{Constants::BASE_URL}/player_stats/player_stats.parquet"
    end
    private_class_method :new
  end

  private_constant :PlayerStats
end