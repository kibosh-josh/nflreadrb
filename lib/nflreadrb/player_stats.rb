# frozen_string_literal: true

module Nflreadrb
  class PlayerStats < BaseLoader
    def initialize(year:)
      @year = year
      @url = "#{Constants::BASE_URL}/player_stats/player_stats.parquet"
    end
    private_class_method :new

    def self.load(year:)
      new(year:).load_data
    end
  end

  private_constant :PlayerStats
end