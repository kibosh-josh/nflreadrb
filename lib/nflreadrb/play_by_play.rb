# frozen_string_literal: true

module Nflreadrb
  # Loads play by play data for a given year. Columns filtering can be added to return only a subset of data
  class PlayByPlay < BaseLoader
    def initialize(year:, columns:)
      super
      @url = "#{Constants::BASE_URL}/pbp/play_by_play_#{year}.parquet"
    end
    private_class_method :new
  end

  private_constant :PlayByPlay
end
