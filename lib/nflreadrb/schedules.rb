# frozen_string_literal: true

module Nflreadrb
  # Loads schedule data for a given year. Columns filtering can be added to return only a subset of data
  class Schedules < BaseLoader
    def initialize(year:, columns:)
      super
      @url = "#{Constants::BASE_URL}/schedules/games.parquet"
    end
    private_class_method :new
  end

  private_constant :Schedules
end
